From: David Lechner <david@lechnology.com>
Date: Fri, 21 May 2021 08:41:34 -0500
Subject: [PATCH 11/11] drm/tiny: drm_gem_simple_display_pipe_prepare_fb is
 the default
In-Reply-To: <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
References: <20210521090959.1663703-1-daniel.vetter@ffwll.ch>
 <20210521090959.1663703-11-daniel.vetter@ffwll.ch>
Message-ID: <15839b4b-04e5-c65a-8e7c-6e1bdce9757f@lechnology.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/21/21 4:09 AM, Daniel Vetter wrote:
> Goes through all the drivers and deletes the default hook since it's
> the default now.

Acked-by: David Lechner <david@lechnology.com>

