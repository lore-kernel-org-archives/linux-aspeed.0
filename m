From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 23 Feb 2024 22:01:15 +0000
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
In-Reply-To: <20240222-getting-nebulizer-8f75ba8063b1@spud>
References: <20240222085914.1218037-1-Kelly_Hung@asus.com>
 <20240222-getting-nebulizer-8f75ba8063b1@spud>
Message-ID: <20240223220115.GB9299@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 22, 2024 at 08:02:07AM PST, Conor Dooley wrote:
>On Thu, Feb 22, 2024 at 04:59:13PM +0800, Kelly Hung wrote:
>> Document the new compatibles used on ASUS X4TF.
>
>It would be good to mention here what the x4tf is - is it a bmc or
>an sbc etc.
>

...and if, as a quick web search indicates is likely the case, it's a
BMC for a server (or family of servers), following the existing naming
convention with something more like "asus,x4tf-bmc" might be nice.

Also, Kelly -- when sending revised versions of patches please use the
'-v' flag to git format-patch to include a version number in the subject
line so it's clearer what's going on.  (So when posting the next version
incorporating the feedback on this one use '-v3', since this appears to
be a v2.)

Zev
