From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 10 Mar 2023 14:54:57 +0100
Subject: [PATCH 01/22] drm/fbdev-dma: Implement fbdev emulation for GEM
 DMA helpers
In-Reply-To: <87o7p2p4n4.fsf@minerva.mail-host-address-is-not-set>
References: <87o7p2p4n4.fsf@minerva.mail-host-address-is-not-set>
Message-ID: <b8bec71e-6e59-7ae1-1258-383f3d492226@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Javier,

thanks for your review.

Am 09.03.23 um 12:04 schrieb Javier Martinez Canillas:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> 
>> Implement fbdev emulation that is optimized for drivers that use
>> DMA helpers. The buffers may no tbe moveable, may not require damage
> 
> "may not be"
> 
> Is may the correct verb here though? I guess you meant "shall not".

I cannnot say for sure, but I always thought 'may not' is a nicer term 
for 'must not'. But RFC2119 disagrees wrt to the use of 'may'. I'll 
change the wording to 'must not'.

> 
>> handling and have to be located in system memory. This allows fbdev
>> emulation to operate directly on the buffer and mmap it to userspace.
>>
>> Besides those constraints, the emulation works like in the generic
>> code. As an internal DRM client provides, it receives hotplug, restore
>> and unregister events. The DRM client is independent from the fbdev
>> probing, which runs on the first successful hotplug event.
>>
>> The emulation is part of the DMA helper module and not build unless
>> DMA helpers and fbdev emulation has been configured.
>>
>> Tested with vc4.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
> 
> [...]
> 
>> +static int drm_fbdev_dma_fb_open(struct fb_info *info, int user)
>> +{
>> +	struct drm_fb_helper *fb_helper = info->par;
>> +
>> +	/* No need to take a ref for fbcon because it unbinds on unregister */
>> +	if (user && !try_module_get(fb_helper->dev->driver->fops->owner))
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +
>> +static int drm_fbdev_dma_fb_release(struct fb_info *info, int user)
>> +{
>> +	struct drm_fb_helper *fb_helper = info->par;
>> +
>> +	if (user)
>> +		module_put(fb_helper->dev->driver->fops->owner);
>> +
>> +	return 0;
>> +}
>> +
> 
> These two functions are the same than what's used by the generic fbdev
> emulation. Maybe they could be moved to drivers/gpu/drm/drm_fb_helper.c
> and be reused ?

I deliberately did not share code between the existing generic fbdev 
emulation and the new one. A number of drivers come with their own fbdev 
code and need conversion to struct drm_client. I want to see if there 
really is a pattern can can be shared in a helper.

I've done 'premature helperization' before and had to undo it later on. 
The existing fbdev code is an example of that. I'm trying to not do this 
mistake again.

> 
>> +static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
>> +					 struct drm_fb_helper_surface_size *sizes)
>> +{
>> +	struct drm_client_dev *client = &fb_helper->client;
>> +	struct drm_device *dev = fb_helper->dev;
>> +	struct drm_client_buffer *buffer;
>> +	struct drm_gem_dma_object *dma_obj;
>> +	struct drm_framebuffer *fb;
>> +	struct fb_info *info;
>> +	u32 format;
>> +	struct iosys_map map;
>> +	int ret;
>> +
>> +	drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
>> +		    sizes->surface_width, sizes->surface_height,
>> +		    sizes->surface_bpp);
>> +
>> +	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
>> +	buffer = drm_client_framebuffer_create(client, sizes->surface_width,
>> +					       sizes->surface_height, format);
>> +	if (IS_ERR(buffer))
>> +		return PTR_ERR(buffer);
>> +	dma_obj = to_drm_gem_dma_obj(buffer->gem);
>> +
>> +	fb = buffer->fb;
>> +	if (drm_WARN_ON(dev, fb->funcs->dirty)) {
>> +		ret = -ENODEV; /* damage handling not supported; use generic emulation */
>> +		goto err_drm_client_buffer_delete;
>> +	}
> 
> Should we have a similar check for drm_fbdev_use_shadow_fb(fb_helper)
> and warn on ?

That function (and several others) will go away soon. After the fbdev 
code for DMA helpers has been merged, generic fbdev will go shadow-fb-only.

> 
>> +
>> +	ret = drm_client_buffer_vmap(buffer, &map);
>> +	if (ret) {
>> +		goto err_drm_client_buffer_delete;
>> +	} else if (drm_WARN_ON(dev, map.is_iomem)) {
>> +		ret = -ENODEV; /* I/O memory not supported; use generic emulation */
> 
> I also wonder if here and above instead of the warn on, there should
> just be a normal check and print more verbose warning messages.

No, because it's a driver bug that should be fixed ASAP. The driver 
should call generic fbdev instead. A regular warning would be 
appropriate for a runtime error over which the driver has no control, 
such as a OOM.

> 
> [...]
> 
>> +static void drm_fbdev_dma_client_unregister(struct drm_client_dev *client)
>> +{
>> +	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
>> +
>> +	if (fb_helper->info) {
>> +		drm_fb_helper_unregister_info(fb_helper);
>> +	} else {
>> +		drm_client_release(&fb_helper->client);
>> +		drm_fb_helper_unprepare(fb_helper);
>> +		kfree(fb_helper);
>> +	}
>> +}
> 
> This is again the same than drm_fbdev_client_unregister() so I think
> that can be made a helper and shared bewteen the two implementations.

I've have the same discussion with Patrik when I sent such an updte for 
gma500. These functions are the same, but I think this will change.

Here in _unregister(), the kfree() expects struct drm_fb_helper. But 
other drivers will certainly have their own structures and then require 
their own unregister helpers.

> 
>> +
>> +static int drm_fbdev_dma_client_restore(struct drm_client_dev *client)
>> +{
>> +	drm_fb_helper_lastclose(client->dev);
>> +
>> +	return 0;
>> +}
> 
> Same for this one.

Maybe more sharable, but there will be a version that supports 
vgaswitcheroo on several drivers.

> 
>> +
>> +static int drm_fbdev_dma_client_hotplug(struct drm_client_dev *client)
>> +{
>> +	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
>> +	struct drm_device *dev = client->dev;
>> +	int ret;
>> +
>> +	if (dev->fb_helper)
>> +		return drm_fb_helper_hotplug_event(dev->fb_helper);
>> +
>> +	ret = drm_fb_helper_init(dev, fb_helper);
>> +	if (ret)
>> +		goto err_drm_err;
>> +
>> +	if (!drm_drv_uses_atomic_modeset(dev))
>> +		drm_helper_disable_unused_functions(dev);
>> +
>> +	ret = drm_fb_helper_initial_config(fb_helper);
>> +	if (ret)
>> +		goto err_drm_fb_helper_fini;
>> +
>> +	return 0;
>> +
>> +err_drm_fb_helper_fini:
>> +	drm_fb_helper_fini(fb_helper);
>> +err_drm_err:
>> +	drm_err(dev, "fbdev-dma: Failed to setup generic emulation (ret=%d)\n", ret);
>> +	return ret;
>> +}
> 
> And this one.

I think, we should try to remove drm_fb_helper_funcs and therefore merge 
probe into hotplug. Each fbdev emulation will then require its own 
_hotplug() function. So this code won't be shareable in the future.

As I outlined before, I intentionally didn't share this code because I 
expect that it will be 'un-shared' in the near future.

> 
>> +/**
>> + * drm_fbdev_dma_setup() - Setup fbdev emulation for GEM DMA helpers
>> + * @dev: DRM device
>> + * @preferred_bpp: Preferred bits per pixel for the device.
>> + *                 @dev->mode_config.preferred_depth is used if this is zero.
>> + *
>> + * This function sets up fbdev emulation for GEM DMA drivers that support
>> + * dumb buffers with a virtual address and that can be mmap'ed.
>> + * drm_fbdev_dma_setup() shall be called after the DRM driver registered
>> + * the new DRM device with drm_dev_register().
>> + *
>> + * Restore, hotplug events and teardown are all taken care of. Drivers that do
>> + * suspend/resume need to call drm_fb_helper_set_suspend_unlocked() themselves.
>> + * Simple drivers might use drm_mode_config_helper_suspend().
>> + *
>> + * This function is safe to call even when there are no connectors present.
>> + * Setup will be retried on the next hotplug event.
>> + *
>> + * The fbdev is destroyed by drm_dev_unregister().
>> + */
>> +void drm_fbdev_dma_setup(struct drm_device *dev, unsigned int preferred_bpp)
>> +{
>> +	struct drm_fb_helper *fb_helper;
>> +	int ret;
>> +
>> +	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
>> +	drm_WARN(dev, dev->fb_helper, "fb_helper is already set!\n");
>> +
>> +	fb_helper = kzalloc(sizeof(*fb_helper), GFP_KERNEL);
>> +	if (!fb_helper)
>> +		return;
>> +	drm_fb_helper_prepare(dev, fb_helper, preferred_bpp, &drm_fbdev_dma_helper_funcs);
>> +
>> +	ret = drm_client_init(dev, &fb_helper->client, "fbdev", &drm_fbdev_dma_client_funcs);
>> +	if (ret) {
>> +		drm_err(dev, "Failed to register client: %d\n", ret);
>> +		goto err_drm_client_init;
>> +	}
>> +
>> +	ret = drm_fbdev_dma_client_hotplug(&fb_helper->client);
>> +	if (ret)
>> +		drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
>> +
>> +	drm_client_register(&fb_helper->client);
>> +
>> +	return;
>> +
>> +err_drm_client_init:
>> +	drm_fb_helper_unprepare(fb_helper);
>> +	kfree(fb_helper);
>> +}
>> +EXPORT_SYMBOL(drm_fbdev_dma_setup);
> 
> And this one could also be shared AFAICT if drm_fbdev_client_hotplug()
> is used instead.
> 
>> diff --git a/include/drm/drm_fbdev_dma.h b/include/drm/drm_fbdev_dma.h
>> new file mode 100644
>> index 000000000000..2da7ee784133
>> --- /dev/null
>> +++ b/include/drm/drm_fbdev_dma.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: MIT */
>> +
>> +#ifndef DRM_FBDEV_DMA_H
>> +#define DRM_FBDEV_DMA_H
>> +
>> +struct drm_device;
>> +
>> +#ifdef CONFIG_DRM_FBDEV_EMULATION
>> +void drm_fbdev_dma_setup(struct drm_device *dev, unsigned int preferred_bpp);
>> +#else
>> +static inline void drm_fbdev_dma_setup(struct drm_device *dev, unsigned int preferred_bpp)
>> +{ }
>> +#endif
>> +
>> +#endif
>> -- 
> 
> And you should be able to drop this header too if split the common
> helpers from drm_fbdev_generic.c or maybe I'm missing something ?

This is the header that drivers include to run DMA fbdev emulation. We 
cannot remove it.

Best regards
Thomas

> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N?rnberg, Germany
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_signature
Type: application/pgp-signature
Size: 840 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230310/30eeef11/attachment-0001.sig>
