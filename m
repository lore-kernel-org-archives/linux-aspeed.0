From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Wed, 12 Jul 2023 12:54:32 +0200
Subject: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
In-Reply-To: <abf26a82-4f17-51f2-5753-785f8516a81a@suse.de>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <abf26a82-4f17-51f2-5753-785f8516a81a@suse.de>
Message-ID: <20230712105432.urgwb4zzwgsyfbwq@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Thomas,

On Wed, Jul 12, 2023 at 12:19:37PM +0200, Thomas Zimmermann wrote:
> Am 12.07.23 um 11:46 schrieb Uwe Kleine-K?nig:
> > Hello,
> > 
> > while I debugged an issue in the imx-lcdc driver I was constantly
> > irritated about struct drm_device pointer variables being named "dev"
> > because with that name I usually expect a struct device pointer.
> > 
> > I think there is a big benefit when these are all renamed to "drm_dev".
> 
> If you rename drm_crtc.dev, you should also address *all* other data
> structures.

Yes. Changing drm_crtc::dev was some effort, so I thought to send that
one out before doing the same to

	drm_dp_mst_topology_mgr
	drm_atomic_state
	drm_master
	drm_bridge
	drm_client_dev
	drm_connector
	drm_debugfs_entry
	drm_encoder
	drm_fb_helper
	drm_minor
	drm_framebuffer
	drm_gem_object
	drm_plane
	drm_property
	drm_property_blob
	drm_vblank_crtc

when in the end the intention isn't welcome.

> > I have no strong preference here though, so "drmdev" or "drm" are fine
> > for me, too. Let the bikesheding begin!
> 
> We've discussed this to death. IIRC 'drm' would be the prefered choice.

"drm" at least has the advantage to be the 2nd most common name. With
Paul Kocialkowski prefering "drm_dev" there is no clear favourite yet.
Maybe all the other people with strong opinions are dead if this was
"discussed to death" before? :-)

Best regards
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230712/d1463546/attachment-0001.sig>
