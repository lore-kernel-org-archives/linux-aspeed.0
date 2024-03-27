From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 27 Mar 2024 12:16:06 +1030
Subject: [PATCH v6 0/2] Add Reviewed-by and Acked-by tags
In-Reply-To: <20240326103549.2413515-1-Kelly_Hung@asus.com>
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
Message-ID: <eb4171d9c46dba2aabca90319028ee6be8c80d55.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kelly,

On Tue, 2024-03-26 at 18:35 +0800, Kelly Hung wrote:
> There are no changes to the Patch file, just the reviewed and acked tags are added.
> PATCH v5 has been merged into the next branch.

As others have said, please don't add tags that have not been
explicitly given for your patches.

Further, if a patch has been added to any upstream "next" branches it's
not necessary to resend the patches beyond that point, unless there are
errors that need correcting.

Joel had added an earlier revision of your patches to a branch of
candidate patches to upstream, and I've updated those in my own that
I'm maintaining while he's on leave. I'd also added your patches to the
OpenBMC kernel tree as a consequence, but you shouldn't apply tags to
your upstream patches that other people didn't provide you on that
basis.

As for the concerns reported by Rob's bot, I've got a series that
cleans up many of them. I'm working to find time to send them out.
Hopefully these help reduce the noise in the future.

Andrew

