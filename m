From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Oct 2020 10:45:42 +0000
Subject: [PATCH 04/21] drm/aspeed: Set driver CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <c3419660-770c-dadd-21bd-9a6dc0e10a8d@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-5-tzimmermann@suse.de>
 <CACPK8XcGOAjocCMp9ubgQpfiBaqSj61i_frSU7ZdiKO_uSt-hQ@mail.gmail.com>
 <3df12a74-d8f3-d607-78ff-5a0f21e86cb9@suse.de>
 <CACPK8XcAXrf6ySuWo4izjD4EU6tMSULs0tP4cy-+TA35PSOUgw@mail.gmail.com>
 <c3419660-770c-dadd-21bd-9a6dc0e10a8d@suse.de>
Message-ID: <CACPK8Xfx=tip4Xuqdo15P7R2cXSEXPr+LuED8ZJS5tQui+rjvg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 9 Oct 2020 at 08:26, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 09.10.20 um 10:06 schrieb Joel Stanley:
> > On Fri, 9 Oct 2020 at 08:01, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >> Hi
> >>
> >> Am 09.10.20 um 09:54 schrieb Joel Stanley:
> >>> On Fri, 22 May 2020 at 13:52, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>>>
> >>>> DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
> >>>> to their defaults. No functional changes are made.
> >>>>
> >>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>>
> >>> I just found this in my inbox. I assume it has not been applied as you
> >>> were after a review.
> >>
> >> The patchset as a whole got an A-b and was merged a while ago.
> >
> > I'm a bit confused, I couldn't see it in any tree. The aspeed one
> > seemed to have been skipped when applying the series.
> >
> > I looked at today's linux-next and drm-misc-next.
>
> Indeed. The other patches are in drm-misc-next, but not this one. I must
> have lost it during the merge process.
>
> >
> >>>
> >>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> >>
> >> Nevertheless thanks for taking a look at the patch.
> >>
> >> Best regards
> >> Thomas
> >>
> >>>
> >>> I will apply it to drm-misc-next.
>
> So please ahead and apply it. There's also an ack by Emil, which you may
> want to add as well.
>
>   Acked-by: Emil Velikov <emil.velikov@collabora.com>
>
> Sorry about missing the patch and thanks for taking care.

No problem. Thanks for the cleanup.

Cheers,

Joel
