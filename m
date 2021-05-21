From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Date: Fri, 21 May 2021 14:13:13 +0000
Subject: [PATCH 11/11] drm/tiny: drm_gem_simple_display_pipe_prepare_fb is
 the default
In-Reply-To: <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
References: <20210521090959.1663703-1-daniel.vetter@ffwll.ch>
 <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
Message-ID: <5c75b291-0b47-92de-e90d-2842b0e5f996@epam.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/21/21 12:09 PM, Daniel Vetter wrote:
> Goes through all the drivers and deletes the default hook since it's
> the default now.
>
> Signed-off-by: Daniel Vetter<daniel.vetter@intel.com>
Acked-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
