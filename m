From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 03 May 2024 23:12:05 -0000
Subject: [PATCH 00/21] pinctrl: Use scope based of_node_put() cleanups
In-Reply-To: <CACRpkdaRpJw=kHtya2iww7vvm+Bt6-oPMmz-6VzfhZniSoMP3w@mail.gmail.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
 <CACRpkdaRpJw=kHtya2iww7vvm+Bt6-oPMmz-6VzfhZniSoMP3w@mail.gmail.com>
Message-ID: <DU0PR04MB9417D5D76707C413ABC0BAC0881F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus,

> Subject: Re: [PATCH 00/21] pinctrl: Use scope based of_node_put() cleanups
> 
> Hi Peng,
> 
> thanks for doing this! I am very much in favor of using scoped management
> of resources where it makes it easier to do the right thing.
> 
> I agree with Krzysztof's comment that we should avoid scoping in cases where
> there is a clear path grab/use/release so the code is easy to read already as it
> is. Let's drop those.
Yeah, will drop them in v2.

> 
> I saw there was some patch that was even a fix, perhaps I should pick that
> one separately for fixes, but probably it is non-urgent.

Not urgent, I will add fix tag in v2.

Thanks,
Peng.
> 
> I suppose we will just apply v2 after people had some time to look at it!
> 
> Yours,
> Linus Walleij
