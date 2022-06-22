From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 22 Jun 2022 22:36:50 +0800
Subject: [PATCH 0/4] Update Facebook Bletchley BMC DTS
In-Reply-To: <Yqdr1ZS6d71QeACd@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
 <Yqdr1ZS6d71QeACd@heinlein.stwcx.org.github.beta.tailscale.net>
Message-ID: <eda3f331-6df4-c4d3-33e5-a872fecd6024@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Patrick Williams ? 6/14/2022 12:54 AM ??:
> On Mon, Jun 13, 2022 at 05:51:46PM +0800, Potin Lai wrote:
>> Update below items for Facebook Bletchley BMC devicetree.
>>
>> Potin Lai (4):
>>   ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
>>   ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
>>   ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
>>   ARM: dts: aspeed: bletchley: update fusb302 nodes
>>
>>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 197 +++++++++++++-----
>>  1 file changed, 148 insertions(+), 49 deletions(-)
Hi Joel,
Could you help me review this patch series?
Could you also backport this to linux-aspeed 5.15 if everything looks good to you?
Thank you.

Potin
> The whole patch set looks good to me as the closest domain expert to the
> Bletchley system after Potin.
>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
>
