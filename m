Return-Path: <linux-aspeed+bounces-424-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFE8E7719D
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 15:45:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV5ZY4N6Gz3cWD;
	Sat, 11 Jan 2025 02:45:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736523909;
	cv=none; b=KeSiK3Hge41H1y2uyQGPccTyuSqwxo714tje0RbvuF1gqlwwKchEIpEer6eza24DD42BwZ9Q0n1DGRvQD9B/wqzqWzbem+HB5A67yE84PfZuInWBlzSjEuzOBkyOEzXgrHBCybPV81YIgg51S2tzdYn152JfhlE62vH8THHs7gni5JdfZwJysDYa2PF3tHjMooxGIDh1AvKqR+gM9Ej/6mIYebE3GfcrFYaApBeJmhVrEayI6OuCQxwDDN9eEpfanf0PDatL6q7b/UvBgFGzTBXNGUx3MrFxhtvrDnDglthtrxAbVrhG8c3rJoNjGqb1s3y3SAXk8zC9SZ2sQ+r6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736523909; c=relaxed/relaxed;
	bh=go6Mt8yoM+PNbuAKxnovA/CqAwsRZWr0IjEkGgkxoZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2F8XHnheoNi+SEWJBSBY+WjoxxGZmu8JJ0EPvjuDja864zEIsT+FEkXyKE9xdzwEJH/u23hzF49OAhiQLcq3guBgkKKng4JZMrqcCS3EzVg3VlqDsOaKV9v8cHXasCrzOx1Ax6gkIQPNM0/MBvqOcoqpkDcwmO7pkHtHyJWJj1SV+yk1knijhnw8GCZIEz93bsi9E+bRo+11qW+50vmTG/jQ4X5bKApTZyxSLxV/K81S1riMqMoj0BZBPMHQisS0rjZ3OPeMiKeJPL8s6qB0R6RhaitUi6rQXb+I7pvtAbeSgRt+vKZjDZfG2fd58T0aXQ8IQbcHlE0bjvo1QMvcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XCQa0pdg; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XCQa0pdg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV5ZW2gzZz3cCd
	for <linux-aspeed@lists.ozlabs.org>; Sat, 11 Jan 2025 02:45:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2C2DDA4255C;
	Fri, 10 Jan 2025 15:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143C8C4CED6;
	Fri, 10 Jan 2025 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736523903;
	bh=OTGkN3XvR9yS3XjEo4HOuIC3KncL4iFmKtSsBY8wwy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCQa0pdg2qxKVtHtTkJ4SGoINH4HtU7FC0jf6BspFQquH/vW75BYx+9A5FEStYCBQ
	 E9JxXVi5iN71mutTaOOXYnQOT2oRUN9f4IAA8zQnPkTUAT+IFiIsoDMc75hRAe3/mQ
	 RJ3i+SA0ugZ/4I04jr7lzzWM6IjPSfwYfS+ZvVkKMRCtfu6bMvkaK6DgBZhUH428gN
	 6+8cSmkG63Gu95c4is8beF+nx5sMV1NKT30rMOnUyX48jfAQ/wCXNVVUtdo7lb/+dH
	 FiwoRnp9ge/xuuiuc1Ihc3S8ozZWKgatnci64pA03MaKC9qvewi3Wz78cjpP6E4KfP
	 gquUU5DOldO0A==
Date: Fri, 10 Jan 2025 09:45:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tianping Fang <tianping.fang@mediatek.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	linux-aspeed@lists.ozlabs.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-tegra@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
Message-ID: <173652390194.2924780.6221015444062586872.robh@kernel.org>
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


On Tue, 07 Jan 2025 14:10:13 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/usb/aspeed,usb-vhub.yaml         | 40 +++++++++----------
>  .../devicetree/bindings/usb/brcm,bdc.yaml     | 14 +++----
>  .../devicetree/bindings/usb/cypress,hx3.yaml  | 24 +++++------
>  .../devicetree/bindings/usb/dwc2.yaml         |  4 +-
>  .../devicetree/bindings/usb/fcs,fsa4480.yaml  | 20 +++++-----
>  .../bindings/usb/intel,keembay-dwc3.yaml      | 30 +++++++-------
>  .../devicetree/bindings/usb/ite,it5205.yaml   | 18 ++++-----
>  .../bindings/usb/maxim,max3420-udc.yaml       | 28 ++++++-------
>  .../bindings/usb/nvidia,tegra210-xusb.yaml    |  4 +-
>  .../bindings/usb/renesas,rzv2m-usb3drd.yaml   | 36 ++++++++---------
>  .../bindings/usb/renesas,usb3-peri.yaml       | 24 +++++------
>  .../devicetree/bindings/usb/ti,hd3ss3220.yaml | 38 +++++++++---------
>  .../bindings/usb/ti,tusb73x0-pci.yaml         |  6 +--
>  .../devicetree/bindings/usb/ti,usb8020b.yaml  | 20 +++++-----
>  .../devicetree/bindings/usb/ti,usb8041.yaml   | 16 ++++----
>  15 files changed, 161 insertions(+), 161 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


