From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 13:05:47 -0500
Subject: [PATCH 01/22] drm/amdgpu: Fix coding style
In-Reply-To: <20230116131235.18917-2-tzimmermann@suse.de>
References: <20230116131235.18917-1-tzimmermann@suse.de> <20230116131235.18917-2-tzimmermann@suse.de>
Message-ID: <CADnq5_P4DgCi_JwXo2fJS=cCBmumsw5Og5ZYt+J4J_Lak74e0Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Applied.  Thanks!
On Mon, Jan 16, 2023 at 8:13 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Align a closing brace and remove trailing whitespaces. No functional
> changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e47058c2c294..0993ee91fe18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5871,8 +5871,8 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>  int amdgpu_in_reset(struct amdgpu_device *adev)
>  {
>         return atomic_read(&adev->reset_domain->in_gpu_reset);
> -       }
> -
> +}
> +
>  /**
>   * amdgpu_device_halt() - bring hardware to some kind of halt state
>   *
> --
> 2.39.0
>
