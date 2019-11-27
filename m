From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 28 Nov 2019 09:58:35 +1030
Subject: [PATCH 07/62] gpio: gpio-aspeed: Use new GPIO_LINE_DIRECTION
In-Reply-To: <493e2f9ed5aff112519adcdf2d3044bf54c2d91a.1572945709.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572945709.git.matti.vaittinen@fi.rohmeurope.com>
 <493e2f9ed5aff112519adcdf2d3044bf54c2d91a.1572945709.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <01b18f38-2faa-4896-9a61-d0c657596c6f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 5 Nov 2019, at 20:42, Matti Vaittinen wrote:
> It's hard for occasional GPIO code reader/writer to know if values 0/1
> equal to IN or OUT. Use defined GPIO_LINE_DIRECTION_IN and
> GPIO_LINE_DIRECTION_OUT to help them out.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Not sure where the series is at, but this looks fine to me:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
