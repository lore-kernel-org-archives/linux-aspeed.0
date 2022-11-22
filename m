From: Zev Weiss <zweiss@equinix.com>
Date: Tue, 22 Nov 2022 23:12:51 +0000
Subject: [PATCH] media: aspeed: Use v4l2_dbg to replace v4l2_warn to avoid
 log spam
In-Reply-To: <20221110095611.522-1-jammy_huang@aspeedtech.com>
References: <20221110095611.522-1-jammy_huang@aspeedtech.com>
Message-ID: <20221122231216.GF18848@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 10, 2022 at 01:56:11AM PST, Jammy Huang wrote:
>If the host is powered off, there will be many warning log. To avoid the
>log spam in this condition, replace v4l2_warn with v4l2_dbg.
>
>Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>---
> drivers/media/platform/aspeed/aspeed-video.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>

Thanks Jammy -- after dropping the one hunk that wasn't applicable (due
to not having all the prerequisite patches) this definitely fixed the
log noise problems I'd been having.

I'm assuming the prerequisite patches are from your aspeed-jpeg support
patch series?  If so, since this is a smaller/simpler patch, I think it
might make sense to reorder things to try to get this merged first and
then fixing up that patchset to use v4l2_dbg() instead of v4l2_warn(),
rather than introducing a new instance of it and then patching it back
out later with this one.


Thanks,
Zev
