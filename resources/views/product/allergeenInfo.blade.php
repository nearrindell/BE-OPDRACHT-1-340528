@vite(['resources/css/app.css', 'resources/js/app.js'])
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Overzicht Allergenen</title>

    @if($noAllergens)
        <!-- redirect na 4 seconden naar product overzicht -->
        <script>
            setTimeout(function() {
                window.location.href = "{{ route('product.index') }}";
            }, 4000);
        </script>
    @endif
</head>
<body>
    <div class="container d-flex justify-content-center">
        <div class="col-md-8">
            <br>
            <h1>{{ $title }}</h1>
            <p class="text-3xl">________________________________________</p>

            @if($product)
                <div class="mt-4 mb-4">
                    <p><strong>Naam:</strong> {{ $product->ProductNaam }}</p>
                    <p><strong>Barcode:</strong> {{ $product->Barcode }}</p>
                </div>
            @endif

            <table class="table table-striped table-bordered align-middle shadow-sm">
                <thead>
                    <tr>
                        <th>Naam</th>
                        <th>Omschrijving</th>
                    </tr>
                </thead>
                <tbody>
                    @if($noAllergens)
                        <tr>
                            <td colspan="2" class="text-center text-danger font-medium">
                                In dit product zitten geen stoffen die een allergische reactie kunnen veroorzaken
                            </td>
                        </tr>
                    @else
                        @forelse ($allergenen as $allergeen)
                            <tr>
                                <td>{{ $allergeen->Naam }}</td>
                                <td>{{ $allergeen->Omschrijving }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="2" class="text-center text-danger font-medium">
                                    Geen allergenen beschikbaar voor dit product
                                </td>
                            </tr>
                        @endforelse
                    @endif
                </tbody>
            </table>

            <a href="{{ route('product.index') }}" class="btn btn-secondary mt-3">Terug naar overzicht</a>
        </div>
    </div>
</body>
</html>
