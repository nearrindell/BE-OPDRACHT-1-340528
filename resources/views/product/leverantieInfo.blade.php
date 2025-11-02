@vite(['resources/css/app.css', 'resources/js/app.js'])
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ $title }}</title>

    @if(!empty($noStock) && $noStock)
        <script>
            // redirect na 4 seconden naar terug naar overzicht
            setTimeout(function() {
                window.location.href = "{{ route('product.index') }}";
            }, 4000);
        </script>
    @endif
</head>
<body>
    <div class="container d-flex justify-content-center">
        <div class="col-md-10">
            <br>
            <h1>{{ $title }}</h1>
            <p class="text-3xl">________________________________________</p>

            <!-- leverancier info -->
            @if($leverancier)
                <div class="mt-4 mb-4">
                    <p><strong>Naam leverancier:</strong> {{ $leverancier->Naam }}</p>
                    <p><strong>Contactpersoon leverancier:</strong> {{ $leverancier->Contactpersoon }}</p>
                    <p><strong>Leveranciernummer:</strong> {{ $leverancier->Leveranciernummer }}</p>
                    <p><strong>Mobiel:</strong> {{ $leverancier->Mobiel }}</p>
                </div>
            @endif

            <table class="table table-striped table-bordered table-hover align-middle shadow-sm">
                <thead>
                    <tr>
                        <th>Naam Product</th>
                        <th class="text-center">Datum laatste levering</th>
                        <th class="text-center">Aantal</th>
                        <th class="text-center">Eerstvolgende levering</th>
                    </tr>
                </thead>
                <tbody>
                    @if(!empty($noStock) && $noStock)
                        <!-- geen voorraad aanwezig melding -->
                        <tr>
                            <td colspan="4" class="text-center text-danger font-medium">
                                Er is van dit product op dit moment geen voorraad aanwezig,
                                de verwachte eerstvolgende levering is: 
                                {{ date('d-m-Y', strtotime($nextDelivery)) }}
                            </td>
                        </tr>
                    @else
                        @forelse ($leveringen as $levering)
                            <tr>
                                <td>{{ $levering->Naam }}</td>
                                <td class="text-center">{{ date('d-m-Y', strtotime($levering->DatumLevering)) }}</td>
                                <td class="text-center">{{ $levering->Aantal }}</td>
                                <td class="text-center">
                                    {{ $levering->DatumEerstVolgendeLevering ? date('d-m-Y', strtotime($levering->DatumEerstVolgendeLevering)) : '-' }}
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center">Geen leveringen beschikbaar</td>
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
