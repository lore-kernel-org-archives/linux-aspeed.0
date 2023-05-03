From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 May 2023 15:13:39 +0300
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com> <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org> <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
 <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com>
Message-ID: <CAA8EJpq8x5wQa3fMebaSP3hCdMiCsZRaF+B4Y3N3royW_CeXCA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 3 May 2023 at 13:39, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 3, 2023, at 03:17, Rob Herring wrote:
> > On Tue, May 2, 2023 at 5:52?PM Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> >> On 02/05/2023 22:40, Rob Herring wrote:
> >> >      'berlin' : 'berlin',
> >> >      'pxa2' : 'pxa',
> >> >      'pxa3' : 'pxa',
> >> >      'pxa' : 'marvell',
> >>
> >> I'd question if it makes sense to split the pxa line. Yes, it was sold
> >> by Intel to Marvell, but IIRC the devices still had some inheritance.
> >> So, if we have the 'pxa' subdir, I'd move Marvell PXAs to that dir too.
> >
> > I think I probably split it because it was different maintainers.
> > Though it doesn't look like pxa168 or pxa910 have any maintainer. They
> > are a mixture of pxa and mmp I think.
>
> I think the original split here is probably the best we can do,
> but there is no good way to do it because of the confusing naming
> and the problem that there is no clear line between pxa and mmp.
> As far as I can tell, the release timeline was:
>
> Intel pxa2xx (mach-pxa, xscale, still exists)
> Intel pxa3xx (mach-pxa, xscale, still exists)
> Intel pxa90x (never merged)
> Marvell pxa93x (mach-pxa, xscale, removed in Linux-6.3, no DT)
> Marvell pxa92x (never merged)
> Marvell pxa91x (mach-mmp, pj1, still exists)
> Marvell pxa168 (mach-mmp, pj1, still exists)
> Marvell pxa95x (mach-pxa, pj4, long gone)
> Marvell pxa688 (mach-mmp, pj4, known as mmp2)
>
> So with pxa93x out of the picture, we can simplify it as using
> 'pxa' as the name for all the above chips with an Intel XScale
> core, and 'marvell' for all the other ones that have a Marvell
> core and exist in mach-mmp.

Should it be 'intel' for pxa[23]xx then?

>
>      Arnd



-- 
With best wishes
Dmitry
