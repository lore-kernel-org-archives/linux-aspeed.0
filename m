From: Doug Anderson <dianders@chromium.org>
Date: Thu, 21 Sep 2023 11:48:01 -0700
Subject: [RFT PATCH 5/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown/remove time for misc drivers
In-Reply-To: <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
References: <20230901234015.566018-1-dianders@chromium.org> <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
Message-ID: <CAD=FV=Vvqd76m-i2vbpVoiTir18S4ceFTd17nGdH1yU+9jhfDw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Fri, Sep 1, 2023 at 4:41?PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver remove (or unbind) time. Among other things, this means
> that if a panel is in use that it won't be cleanly powered off at
> system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart and at driver remove (or unbind) time comes
> straight out of the kernel doc "driver instance overview" in
> drm_drv.c.
>
> A few notes about these fixes:
> - I confirmed that these drivers were all DRIVER_MODESET type drivers,
>   which I believe makes this relevant.
> - I confirmed that these drivers were all DRIVER_ATOMIC.
> - When adding drm_atomic_helper_shutdown() to the remove/unbind path,
>   I added it after drm_kms_helper_poll_fini() when the driver had
>   it. This seemed to be what other drivers did. If
>   drm_kms_helper_poll_fini() wasn't there I added it straight after
>   drm_dev_unregister().
> - This patch deals with drivers using the component model in similar
>   ways as the patch ("drm: Call drm_atomic_helper_shutdown() at
>   shutdown time for misc drivers")
> - These fixes rely on the patch ("drm/atomic-helper:
>   drm_atomic_helper_shutdown(NULL) should be a noop") to simplify
>   shutdown.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c |  7 +++++++
>  drivers/gpu/drm/mgag200/mgag200_drv.c   |  8 ++++++++
>  drivers/gpu/drm/pl111/pl111_drv.c       |  7 +++++++
>  drivers/gpu/drm/stm/drv.c               |  7 +++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c     | 11 ++++++++++-
>  drivers/gpu/drm/tve200/tve200_drv.c     |  7 +++++++
>  drivers/gpu/drm/vboxvideo/vbox_drv.c    | 10 ++++++++++
>  7 files changed, 56 insertions(+), 1 deletion(-)

Landed on drm-misc-next:

3c4babae3c4a drm: Call drm_atomic_helper_shutdown() at shutdown/remove
time for misc drivers
