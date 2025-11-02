@vite(['resources/css/app.css', 'resources/js/app.js'])
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leverings Informatie</title>
</head>
<body>
    <div class="container d-flex justify-content-center">
        <div class="col-md-10">
            <br>
            <h1>{{ $title }}</h1>
<p class="text-3xl">________________________________________</p>

            <!-- Leverancier info displayed without card -->
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
                </tbody>
            </table>

            <a href="{{ route('product.index') }}" class="btn btn-secondary mt-3">Terug naar overzicht</a>
        </div>
    </div>
</body>
</html>
