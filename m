From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 13 Jul 2023 12:03:39 +0200
Subject: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
In-Reply-To: <CAMuHMdWuvkxcj05OTfEn5f2p-6e71QEHVjSLWwNFRnR_=WEJVQ@mail.gmail.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <20230712161025.22op3gtzgujrhytb@pengutronix.de>
 <CAMuHMdWuvkxcj05OTfEn5f2p-6e71QEHVjSLWwNFRnR_=WEJVQ@mail.gmail.com>
Message-ID: <20230713100339.a3ve3ixhuwqyrp4d@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 13, 2023 at 08:52:12AM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
> 
> Let's add some fuel to keep the thread alive ;-)
> 
> On Wed, Jul 12, 2023 at 6:13?PM Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Jul 12, 2023 at 05:34:28PM +0300, Jani Nikula wrote:
> > > I think this is an unnecessary change. In drm, a dev is usually a drm
> > > device, i.e. struct drm_device *.
> >
> > Well, unless it's not. Prominently there is
> >
> >         struct drm_device {
> >                 ...
> >                 struct device *dev;
> >                 ...
> >         };
> >
> > which yields quite a few code locations using dev->dev which is
> > IMHO unnecessary irritating:
> >
> >         $ git grep '\<dev->dev' v6.5-rc1 drivers/gpu/drm | wc -l
> >         1633
> 
> I find that irritating as well...
> 
> Same for e.g. crtc->crtc.
> 
> Hence that's why I had sent patches to rename the base members in the
> shmob_drm-specific subclasses of drm_{crtc,connector,plane} to "base".
> https://lore.kernel.org/dri-devel/b3daca80f82625ba14e3aeaf2fca6dcefa056e47.1687423204.git.geert+renesas at glider.be
> 
> > Also the functions that deal with both a struct device and a struct
> > drm_device often use "dev" for the struct device and then "ddev" for
> > the drm_device (see for example amdgpu_device_get_pcie_replay_count()).
> 
> I guess you considered "drm_dev", because it is still a short name?

I considered drm_dev because it is still moderately short and a good
approximation of "drm_device". Other than that the main driving force to
pick "drm_dev" was that it's unique enough that I could have done
s/\<drm_dev\>/$nameofchoice/ on the initial patch and get it mostly
right.

> Code dealing with platform devices usually uses "pdev" and "dev".
> Same for PCI drivers (despite "pci_dev" being a short name).

pci_dev and platform_device both typlically using pdev already annoyed
me in the past. However less than drm_device *dev because for pci_dev +
platform_device there is little overlap.

> So my personal preference goes to "ddev".

I sticked to "drm" for the new series. I think this provides less fuel.

Best regards and thanks for your thoughts,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230713/ecf3b3ad/attachment-0001.sig>
