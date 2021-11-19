From: Maxime Ripard <maxime@cerno.tech>
Date: Fri, 19 Nov 2021 12:00:57 +0100
Subject: (subset) [PATCH] drm/aspeed: Fix vga_pw sysfs output
In-Reply-To: <20211117010145.297253-1-joel@jms.id.au>
References: <20211117010145.297253-1-joel@jms.id.au>
Message-ID: <163731964127.830809.15279573029825789668.b4-ty@cerno.tech>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 17 Nov 2021 09:01:45 +0800, Joel Stanley wrote:
> Before the drm driver had support for this file there was a driver that
> exposed the contents of the vga password register to userspace. It would
> present the entire register instead of interpreting it.
> 
> The drm implementation chose to mask of the lower bit, without explaining
> why. This breaks the existing userspace, which is looking for 0xa8 in
> the lower byte.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
