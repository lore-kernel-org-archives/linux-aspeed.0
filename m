From: Jani Nikula <jani.nikula@intel.com>
Date: Thu, 13 Jul 2023 12:03:05 +0300
Subject: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
In-Reply-To: <20230712161025.22op3gtzgujrhytb@pengutronix.de>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <20230712161025.22op3gtzgujrhytb@pengutronix.de>
Message-ID: <878rbkgp4m.fsf@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> Hello Jani,
>
> On Wed, Jul 12, 2023 at 05:34:28PM +0300, Jani Nikula wrote:
>> On Wed, 12 Jul 2023, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>> > Hello,
>> >
>> > while I debugged an issue in the imx-lcdc driver I was constantly
>> > irritated about struct drm_device pointer variables being named "dev"
>> > because with that name I usually expect a struct device pointer.
>> >
>> > I think there is a big benefit when these are all renamed to "drm_dev".
>> > I have no strong preference here though, so "drmdev" or "drm" are fine
>> > for me, too. Let the bikesheding begin!
>> >
>> > Some statistics:
>> >
>> > $ git grep -ohE 'struct drm_device *\* *[^ (),;]*' v6.5-rc1 | sort | uniq -c | sort -n
>> >       1 struct drm_device *adev_to_drm
>> >       1 struct drm_device *drm_
>> >       1 struct drm_device          *drm_dev
>> >       1 struct drm_device        *drm_dev
>> >       1 struct drm_device *pdev
>> >       1 struct drm_device *rdev
>> >       1 struct drm_device *vdev
>> >       2 struct drm_device *dcss_drv_dev_to_drm
>> >       2 struct drm_device **ddev
>> >       2 struct drm_device *drm_dev_alloc
>> >       2 struct drm_device *mock
>> >       2 struct drm_device *p_ddev
>> >       5 struct drm_device *device
>> >       9 struct drm_device * dev
>> >      25 struct drm_device *d
>> >      95 struct drm_device *
>> >     216 struct drm_device *ddev
>> >     234 struct drm_device *drm_dev
>> >     611 struct drm_device *drm
>> >    4190 struct drm_device *dev
>> >
>> > This series starts with renaming struct drm_crtc::dev to drm_dev. If
>> > it's not only me and others like the result of this effort it should be
>> > followed up by adapting the other structs and the individual usages in
>> > the different drivers.
>> 
>> I think this is an unnecessary change. In drm, a dev is usually a drm
>> device, i.e. struct drm_device *.
>
> Well, unless it's not. Prominently there is
>
> 	struct drm_device {
> 		...
> 		struct device *dev;
> 		...
> 	};
>
> which yields quite a few code locations using dev->dev which is
> IMHO unnecessary irritating:
>
> 	$ git grep '\<dev->dev' v6.5-rc1 drivers/gpu/drm | wc -l
> 	1633
>
> Also the functions that deal with both a struct device and a struct
> drm_device often use "dev" for the struct device and then "ddev" for
> the drm_device (see for example amdgpu_device_get_pcie_replay_count()).

Why is specifically struct drm_device *dev so irritating to you?

You lead us to believe it's an outlier in kernel, something that goes
against common kernel style, but it's really not:

$ git grep -how "struct [A-Za-z0-9_]\+ \*dev" | sort | uniq -c | sort -rn | head -20
  38494 struct device *dev
  16388 struct net_device *dev
   4184 struct drm_device *dev
   2780 struct pci_dev *dev
   1916 struct comedi_device *dev
   1510 struct mlx5_core_dev *dev
   1057 struct mlx4_dev *dev
    894 struct b43_wldev *dev
    762 struct input_dev *dev
    623 struct usbnet *dev
    561 struct mlx5_ib_dev *dev
    525 struct mt76_dev *dev
    465 struct mt76x02_dev *dev
    435 struct platform_device *dev
    431 struct usb_device *dev
    411 struct mt7915_dev *dev
    398 struct cx231xx *dev
    378 struct mei_device *dev
    363 struct ksz_device *dev
    359 struct mthca_dev *dev

A good portion of the above also have a dev member.

Are you planning on changing all of the above too, or are you only
annoyed by drm?

I'm really not convinced at all.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
