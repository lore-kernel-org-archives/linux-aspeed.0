Return-Path: <linux-aspeed+bounces-4822-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A59CC5B572
	for <linux-aspeed@archiver.kernel.org>; Sat, 22 Aug 2026 03:21:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRjBn3hchz2yDr;
	Sat, 22 Aug 2026 13:21:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787312712;
	cv=none; b=OOwVGeArp5DCv+hTRAdlDt7pssi5CDFt73+ybyDT2fDdW9FR8eMjB55k9DaauPy6yCDDCTrHPZg8WZc2+BpVYWKQNwPzjust2w/baWgcdteA+3YToy1+q+eCw5p597QRUnSwttIdTtHZW8urJRgyI3116c/0zLqg+aVE0gw4APX+sOvmSVUkPBjhSr/r/zyWG2uBo+lPOm70bZjQHsyerWiVNUIaRiJVPRO/0wRw9HquAI8gHO3Kyj6TlcZWW9eb7uQIqhXpWwwOTBvHn1+G1+ZQFmZWq5jb4comt4gM1y60o7sFoPnZC0/MeYXuYi3fB8Ii35deYIH0J6IphsR9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787312712; c=relaxed/relaxed;
	bh=2dAxTCvnWQHdzet60v9peB5BpAu+xzdvRTiBy/vj54k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaM4oPxqJNu5aqByrfCTgifmDEBNEF06bKl609o9MEEOrnBZN2qcPxwppg0v+6qo57vc6OQALy/AdHXoZezqCMVUlhLULh4FxgnoRjVqhMF3Gf6wAYxEhFaMpOJgCfQqPxFVNUIi4HfKXhaCJ7mzwymRu0Pt9lDRbqTNRAqfdWG/lPI60QuUs28lwNzbwUJVCqoexCkADUhdQvJazga2D33hlFIruE5PerNsdSuj3oK6xFfeo3aa5HSF9T6P797EWeEZRvcEbHomZzSJ3r+B5G8nOiHRe4kfOD5wNiMCcXVIyBAeC5eejMsSJVn9mZxupzsYcc+z0Bw5R+25RujyxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VdgImv2G; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TD52UVRT; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VdgImv2G;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TD52UVRT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRJQG4V8sz2xWt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 21:45:09 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9MAu22006587
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 11:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2dAxTCvnWQHdzet60v9peB5B
	pAu+xzdvRTiBy/vj54k=; b=VdgImv2GIIYlPoA7bawOCdd/z5eOizLUkWtHiKHG
	fMJ8kehGNhTBZ0h8fQUpLmO4aHVb4Mho+58HJbtXJmK7pzA7iwmysMFI9YwLuJLd
	0vJSyyQpP6DmL8TfPIZx52bXvBmaOa490uwxGO8tVnTT5LQPCWLV/uSDteUOUqma
	tE65aj8LOjjW4Z/rx/aq+6zvt9jwn5DM+o8amnjPhmorMlOraz66r8EKsa6q4pa0
	p5Q6NGTAo6FeLQBpnvIZHqRMWgICdneh/tjNO4EQy9HTiegVbpRhgIpeHu85e56G
	ImFfg188wowSrriSTZS6q40qjqQT91C/Gs57w7aUUKPu3Q==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gddhbr0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 11:45:05 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9771c8f5045so711011241.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787312705; x=1787917505; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2dAxTCvnWQHdzet60v9peB5BpAu+xzdvRTiBy/vj54k=;
        b=TD52UVRTLqCCwaBh38Rui3eM0dEuXEJ0FKyzYTTr8HHLesR3tIyAarc7eyKbRUXdgZ
         eL5rA90RlOfbj6NnLv5WqvMdIsc5IFPrQuKglZ9m/ncx40/e/httt8f+zETHoxzAR8mr
         tZgHv55TxkJI0D08jNetnaaenb25B+fJ00rLKMDoGIUkygJ+6AwwPmJMCNqdN8vhRU+D
         bUFv4yt0WLYBLO7HdhUVldGVENNUPPCcOQO60Qc6uSGzcomi1QDBDzUV/Xyc0KbHPzs+
         ojT8o02uYj3xNMDBrzTUEoYconYYpk9cDV+5d9tXHn/6dlDIO5P3TYuxjLaKdplA6Lze
         wHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312705; x=1787917505;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dAxTCvnWQHdzet60v9peB5BpAu+xzdvRTiBy/vj54k=;
        b=F6qL4l8GHUj9xohseS8BzXhE1jApJ3PTEOT/S+nCisXCw+27rvM90jjEEc3xK0kKES
         qnPxj6oO9WwCCLVg/o0/ZmleyqvBf9eMnsif35FCT25WcdU69veYdkPPAiDa//+N6Zlj
         fiCtU9bBz+rVC3MAS4Q7GUo/obX115DUdI2q62AwKieTjwhTE5U1mk55QFSQLWT+6cLD
         OwZw/RlJJZu/zyHWHQW0yK/sJTGv8Knt3BHWy0p0pa2BRl5h8Z4BYa+rWinXuKe2pUzq
         JjAjnLiCUX/rmFGWnZoGS8Y8PZTL2PVJFvvMz1gQt2XLkLvTh5N7S02bIxCyFj1jtt+S
         dYPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfvdQzdaTHPrnhct2K+KzV7MloKSJbCBjCka2Wwj8Fa5Mc7xUYcISQNHne2KcxX+T5izrJEGGPKSGen4A=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lgCHgOOmKQnTSfaB+GHXeRyjqpSFiS0iQZSrnlnp2RRYzdSbEO
	62uoyuoWFQlPd7zfsvl/XbcigpK+//J3IQEdujByeqUFn/7QyxseLJqXbPaU48stpwqpf4+405q
	pYH6fV0KL9M3AQWqCsFeJ7cVapchaZ62Og2gjDS4izZHAzY3NCl95wkLxQVfED+y2dwNS
X-Gm-Gg: AR+sD10uX+41jLaqx97d0M7iXS6JOOteyox4dnG7vGpnEC5WwjHW5uYsP+Vy5mOZo09
	zq2meLVKtgPKkPve4PNGOuzMoLwfUnQ0mJMDFRGgq19WL7bWZTLj2ZetI6ZFWuKcywC02gWtXSQ
	FbB2+NrskcSd58byYH9f+Qcvph8jeLvUmALitleOcq1iS5g5qJ0ntegpBcyko2tx39wAVpE2Rft
	7nH/ygFNlmMvUVPFnDCYKpaT+vSZzrrvPi1f8/rx8BqKcNBD+GH94mG8kdUqk5fRdIr3mKk4ytP
	dIAc3vIHNbqCcERc8udPnz+nFf/fwgNoyIIIrNZ/E34RjNVesO/NvLA+U9xNIy1U8Z4N66UV97s
	hjhdOsFn7f7VFwcE=
X-Received: by 2002:a05:6102:8083:b0:77b:63e3:6555 with SMTP id ada2fe7eead31-77b63e3c773mr239224137.12.1787312705064;
        Fri, 21 Aug 2026 04:45:05 -0700 (PDT)
X-Received: by 2002:a05:6102:8083:b0:77b:63e3:6555 with SMTP id ada2fe7eead31-77b63e3c773mr239156137.12.1787312704554;
        Fri, 21 Aug 2026 04:45:04 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d52sm6458300a12.2.2026.08.21.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:45:03 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:44:57 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Linus Walleij <linusw@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        David Lechner <david@lechnology.com>, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        arm-scmi@vger.kernel.org, imx@lists.linux.dev,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        soc@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 13/45] clk: imx: Make sure clk_init_data is fully
 initialized
Message-ID: <gj4re27ahv3pusk5coh55xqrtj5dkigywa3sqysnifxpwsf5ch@fl6guu2elgnb>
References: <cover.1787239813.git.geert+renesas@glider.be>
 <7300fde72b6449d2cd7c043e4caec9a6c4171424.1787239813.git.geert+renesas@glider.be>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7300fde72b6449d2cd7c043e4caec9a6c4171424.1787239813.git.geert+renesas@glider.be>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfX1PX4krzQIR9R
 w+DeAg4LKeTYi2TIEqqhKwoivas0crPw0tAZpC/C/WBgXG8xonJHg93zc9OCnU3Fw7Vw++ZVAwb
 EePPDsfKbnHVZMorkvHlSEgtVXf2Pv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4OSBTYWx0ZWRfX9FWxbmB9hCHG
 QNQOEQYz4FE5AR78FdsvQIEXQ78NGu73KlO30HatUxArvziemeI37+qkFtLZmTvqZZ5HWhsnpDp
 w8lGJX9eMwfksZSWMn2n4DNc8UFO6Bnkz9u1/1Lm+b++eDnhcz16XdeR2t0SRGHMFIj3optBqUS
 QSCf6euSsXg2FB82rK1xqzJeYWwrqpOyeVw2aorIBrRIFxclN9QrxxhmIQ8waeufHlFdjWumC7R
 OFNrspV95Id70LZNpCYEY/4ResiwJtPWUv+AqythPsh7NF7bMemUDde9ASQXEIN/MRThZOrKH10
 aNOSM1liknHPGHfEBn2i/q0iWLL/9oS4xdKb+TE5+Td0X+KiivVJXMY86gVV3R80fkoP+MNWBNQ
 chYmOJeqMO1vFBAtER1nFQcv+iUtuIg916FxFjktoykIPk0KrHhgGD55znjth6gtHzEMqAmE2vQ
 3c6qzhBiq9Lng0PjUdg==
X-Authority-Analysis: v=2.4 cv=ApHeGu9P c=1 sm=1 tr=0 ts=6a883a41 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yQKkdfHF0SNApnWj8YgA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: iCHom22vq3VBLy1od4_G1Fd85sMYgH7c
X-Proofpoint-ORIG-GUID: iCHom22vq3VBLy1od4_G1Fd85sMYgH7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210089

On 26-08-21 10:53:23, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

