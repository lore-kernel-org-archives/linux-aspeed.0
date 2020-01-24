From: Sasha Levin <sashal@kernel.org>
Date: Fri, 24 Jan 2020 15:29:17 -0500
Subject: [PATCH AUTOSEL 4.19 05/11] ARM: config: aspeed-g5: Enable
 8250_DW quirks
In-Reply-To: <CACPK8XeGLW6cm9UV7gqrOF18BzsRBppzLQLY6G=Y2MDj2Yrnhw@mail.gmail.com>
References: <20200124011747.18575-1-sashal@kernel.org>
 <20200124011747.18575-5-sashal@kernel.org>
 <CACPK8XeGLW6cm9UV7gqrOF18BzsRBppzLQLY6G=Y2MDj2Yrnhw@mail.gmail.com>
Message-ID: <20200124202917.GI1706@sasha-vm>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 24, 2020 at 01:21:40AM +0000, Joel Stanley wrote:
>HI Sasha,
>
>On Fri, 24 Jan 2020 at 01:17, Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Joel Stanley <joel@jms.id.au>
>>
>> [ Upstream commit a5331a7a87ec81d5228b7421acf831b2d0c0de26 ]
>>
>> This driver option is used by the AST2600 A0 boards to work around a
>> hardware issue.
>
>This hardware was only supported from 5.4+, so I think we can drop this patch.

I'll drop it for 4.19 and older, thanks!

-- 
Thanks,
Sasha
