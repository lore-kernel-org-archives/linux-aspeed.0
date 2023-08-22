From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Aug 2023 17:35:51 -0500
Subject: [PATCH v2 21/23] soc: sunxi: Explicitly include correct DT includes
In-Reply-To: <CAL_Jsq+Ssha5KdBdJ+7c3cxuy+VqWRUjSa=YM78gKi5mZAwvgQ@mail.gmail.com>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
 <20230803-dt-header-cleanups-for-soc-v2-21-d8de2cc88bff@kernel.org>
 <5696647.DvuYhMxLoT@jernej-laptop> <CAL_Jsq+Ssha5KdBdJ+7c3cxuy+VqWRUjSa=YM78gKi5mZAwvgQ@mail.gmail.com>
Message-ID: <CAL_JsqKL7x0JCW476dU=Q5dQOCjLkBq4xcZSJAKzBiLK94nsHA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 22, 2023 at 5:30?PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Aug 6, 2023 at 6:42?AM Jernej ?krabec <jernej.skrabec@gmail.com> wrote:
> >
> > Dne petek, 04. avgust 2023 ob 00:43:01 CEST je Rob Herring napisal(a):
> > > The DT of_device.h and of_platform.h date back to the separate
> > > of_platform_bus_type before it as merged into the regular platform bus.
> > > As part of that merge prepping Arm DT support 13 years ago, they
> > > "temporarily" include each other. They also include platform_device.h
> > > and of.h. As a result, there's a pretty much random mix of those include
> > > files used throughout the tree. In order to detangle these headers and
> > > replace the implicit includes with struct declarations, users need to
> > > explicitly include the correct includes.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Applied to sunxi tree, thanks!
>
> Did you really? Doesn't look like this is in linux-next.

Sorry, it's just the genpd part that isn't since that moved.

Rob
