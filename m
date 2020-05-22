From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 22 May 2020 19:19:53 +0100
Subject: [PATCH 00/21] drm: Convert most CMA-based drivers to GEM object
 functions
In-Reply-To: <20200522135246.10134-1-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
Message-ID: <CACvgo52ajrBxHoyVZKf08GkNSa77NWkufDPXcB=dcWmvMQZuKw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas,

On Fri, 22 May 2020 at 14:53, Thomas Zimmermann <tzimmermann@suse.de> wrote:

>  32 files changed, 52 insertions(+), 226 deletions(-)
>
We need more diffstat like this. With this series the .gem_print_info
is no longer set.
Feel free to follow-up and nuke it, alongside the glue in drm_gem.c.

There's a small comment in the kirin patch - with that resolved the series is:
Acked-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
