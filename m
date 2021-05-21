From: Noralf Trønnes <noralf@tronnes.org>
Date: Fri, 21 May 2021 16:09:13 +0200
Subject: [PATCH 11/11] drm/tiny: drm_gem_simple_display_pipe_prepare_fb is
 the default
In-Reply-To: <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
References: <20210521090959.1663703-1-daniel.vetter@ffwll.ch>
 <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
Message-ID: <0b2b3fd7-7740-4c4e-78a5-142a6e9892ea@tronnes.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Den 21.05.2021 11.09, skrev Daniel Vetter:
> Goes through all the drivers and deletes the default hook since it's
> the default now.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Noralf Tr?nnes <noralf@tronnes.org>
