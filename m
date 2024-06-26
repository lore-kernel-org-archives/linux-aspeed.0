From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 26 Jun 2024 10:21:08 -0000
Subject: [PATCH v2 00/20] pinctrl: Use scope based of_node_put() cleanups
In-Reply-To: <CACRpkdb17buPQVupCRDthvAgMKpvKvRWEN5GbA7pyF9NxymGEg@mail.gmail.com>
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <AM6PR04MB594163BAB898D8689A94056F88CE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <CACRpkdb17buPQVupCRDthvAgMKpvKvRWEN5GbA7pyF9NxymGEg@mail.gmail.com>
Message-ID: <59656f18-e11f-413a-b251-ed65847730b1@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/06/2024 12:02, Linus Walleij wrote:
> On Tue, Jun 18, 2024 at 1:52?PM Peng Fan <peng.fan@nxp.com> wrote:
> 
>>> Subject: [PATCH v2 00/20] pinctrl: Use scope based of_node_put()
>>> cleanups
>>
>> st/stm32/renesas patches are picked. Would you handle the remaining
>> ones?
> 
> Hm right, I applied all that apply cleanly:
> 971c8b4c08e7 (HEAD -> devel) pinctrl: samsung: Use scope based
> of_node_put() cleanups
> 3a882554a3bb pinctrl: k210: Use scope based of_node_put() cleanups
> 7f500f2011c0 pinctrl: freescale: mxs: Fix refcount of child
> d7f5120a944a pinctrl: pinconf-generic: Use scope based of_node_put() cleanups
> 240c5f238d59 pinctrl: bcm: bcm63xx: Use scope based of_node_put() cleanups
> 3a0278cfb448 pinctrl: mediatek: Use scope based of_node_put() cleanups
> c957ae7e7e68 pinctrl: nomadik: Use scope based of_node_put() cleanups
> 3dcc01b36f18 pinctrl: s32cc: Use scope based of_node_put() cleanups
> 7c2aabb56f92 pinctrl: at91: Use scope based of_node_put() cleanups
> 56c42f6c7b2c pinctrl: rockchip: Use scope based of_node_put() cleanups
> 8c5dc2a5b3a7 pinctrl: spear: Use scope based of_node_put() cleanups
> 794e5dc533b0 pinctrl: sprd: Use scope based of_node_put() cleanups
> 8fa99c00351c pinctrl: starfive: Use scope based of_node_put() cleanups
> 11eefc0ac884 pinctrl: tegra: Use scope based of_node_put() cleanups
> 
> Can you look into rebasing the remaining ones?
> 
> I am a bit unsure about Samsung, Krzysztof usually pick these, but no big
> deal I guess, if he objects I can just take it out again.

I can grab that one.

Best regards,
Krzysztof

