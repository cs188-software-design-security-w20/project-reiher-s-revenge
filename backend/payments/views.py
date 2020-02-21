import stripe 

from django.shortcuts import render
from django.conf import settings
from django.views.generic.base import TemplateView

from accounts.views.wallet import WalletAPI 

stripe.api_key = settings.STRIPE_SECRET_KEY

class HomePageView(TemplateView):
    template_name = 'home.html'
    def get_context_data(self, **kwargs): 
        context = super().get_context_data(**kwargs)
        context['key'] = settings.STRIPE_PUBLISHABLE_KEY
        return context

def charge(request):
    if request.method == 'POST':
        charge = stripe.Charge.create(
            amount=500,
            currency='usd',
            description='A Django charge',
            source=request.POST['stripeToken']
        )
        if charge.outcome.network_status == 'approved_by_network' and charge.outcome.type == "authorized":
            # ADD akrambucks here
            return render(request, 'charge.html')



