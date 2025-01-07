Return-Path: <linux-aspeed+bounces-344-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD6EE77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 22:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSRHS0LmZz2yD5;
	Wed,  8 Jan 2025 09:56:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.194.8.81
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736271704;
	cv=none; b=Pe3cbC2suqZsbPHzF2b/rK73q7/A8VH2544RSVW8Ix/Y45Wk8RtotMec4h5qlxogGOPxKBqSKipZJqAfPsW75BRBFBHHtI1dHAiDZJ/CndXW7t1p9o4MhJ65Ek5+c2S5qgIsJaqdAMQlcYOAzdu3UaHLfTEmEXOh9hx2Lqc0UGhp6xtUAqeY+DkuDHAMesDDySZwjzuUORaVvaRaZwptvqtDRFrwmX16b2AClUxRMVhK8F2tHfxJLCvZOQTS7FtEDiErbhGJ2xgGK3fzc9OZDdDwIETzSn6HuZM0Jta+uPVVTW+tb8beKBTsaHTgPT6WPtcb3Q2TGGEHkbHcpVimFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736271704; c=relaxed/relaxed;
	bh=YpsA1hCVY3ewqxQ7j406xH50/PlVnUrpfZDhJ2TaT4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxD36apULtFAp3boHV0dr7LHDmcnhVWkQaTu4hlQD24neAIu+04mwH0pcG9zHYXzExGhz+RKcoaB/TKPi+/0U7i3ee59Bc75WFd0COWtJhGveTrNVnjnjTOEQ6sCKuJ2fq5mVwHy1KMuLE5a8r8bBrS+vMhxBs4ikeDgvWpw0gXIEiJBbzqagCtP/Ays+3qtGstJXZgoG1TienkHI1eD2Sd0pL1twUwHVr9iiEUVyBdBwgYdxyYY4me52IoJxZn7qQYBU+SGk8ZxNFF0HIDIKQgkzuxstkxG83hprZ6qGu7xNHrKcPgwYtCqoal8kXqTfBmNQ5w57JsN8LSDPdxJSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=dZXZV8FC; dkim-atps=neutral; spf=pass (client-ip=217.194.8.81; helo=mail11.truemail.it; envelope-from=francesco@dolcini.it; receiver=lists.ozlabs.org) smtp.mailfrom=dolcini.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=dZXZV8FC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=dolcini.it (client-ip=217.194.8.81; helo=mail11.truemail.it; envelope-from=francesco@dolcini.it; receiver=lists.ozlabs.org)
X-Greylist: delayed 483 seconds by postgrey-1.37 at boromir; Wed, 08 Jan 2025 04:41:38 AEDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSJJL4PDYz2yhM
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 04:41:38 +1100 (AEDT)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BEB121F948;
	Tue,  7 Jan 2025 18:33:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1736271195;
	bh=YpsA1hCVY3ewqxQ7j406xH50/PlVnUrpfZDhJ2TaT4A=; h=From:To:Subject;
	b=dZXZV8FCflkSbXZf2ez6Y/NLj/wwpNR69lN/ozvq6wc0hHsv7aNHN7bcmznN1fdB1
	 8nR/aEIIP3JLTbzZhig7PZp7yrl0IFr4Zr1/jDq7/s4oA3XAZKIk27q1Yl8knhi4Cm
	 /UyHsYkvK+OMnN01osdNq0nQH6wZLtjMutCoy5r5VyrM6fNWTibTQhWJTC0coHFvM8
	 AMa/AAx+f+KLs2A38kPgagH0qrkgOm+K/deSLLzj1Uhk2rHErYdrWDDkqDkkVSWOH6
	 y/dvfV7H0prkHth0t+jSdD20DJp085U9PyAYfNDEnuYZqi34cJY+/bpQG9CK5LGqW9
	 av41Gza7na4cg==
Date: Tue, 7 Jan 2025 18:33:11 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Justin Chen <justin.chen@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Del Regno <angelogioacchino.delregno@collabora.com>,
	Tianping Fang <tianping.fang@mediatek.com>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
Message-ID: <20250107173311.GA72209@francesco-nb>
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>

On Tue, Jan 07, 2025 at 02:10:13PM +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # ti,tusb73x0-pci.yaml



