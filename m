Return-Path: <linux-aspeed+bounces-4994-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C830C88E7F
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Sep 2026 15:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkmt803X3z2yFW;
	Wed, 16 Sep 2026 01:59:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789487967;
	cv=none; b=H70UhUCDEQYrjMXi8aC7bNq+B8vBQBhi9WSTfGK7NuyZHqd9NtLKg4/5wrcNf6KCLbPRMzMqAbx7y4yVEjgFoeXCXA79ylOWqSZZVC+Yl0w+Aa7dN7Tuz0FwSC0ifUiyEPpvvpJva8ta8KBU9BAREFTg4EfqQ8hobFrs8OSRkToQPqEsn9eBe6DMGCnXSVaEiAUMA1fRcmlhpJvTFGCNuKNZ97AF/42s4AATCLLm2bnSXf46ZfMag9U6atE3AVNK7fgOH6cd+rMVBhsO9H87tRNL/JhquYPd6949qjoOBQMRvtsJtHtnDg2Ixd6Y5s9fwS8JrV0mq+Mqj6Ri/lS9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789487967; c=relaxed/relaxed;
	bh=zoQnvWJcYM6jWh3BQe6fMcD0McD2eFAd0RK9LMhbgHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8Th994D1R8SAq8PfNkPje+Z9HZZWQYRnEyNNyOOQxavXS65mVhUUY+ZeUT7WFK4TqsNa2rJOLnWT/ouG7j5A33Zf5YDgmuqgLvieqU4zQTdnvd79Hxz0xN0P6pAQk/cyr963b6wnEK4I4amj+39Fmb8Fw4UYUrGPs9gsu8T0ipuxRVb25DYHlRhaBd8I11QS8qNXeIXvuPpu0jc/HMg/3sdy4SJABkmJ4aOlo7CYOwJwxV3xfFTZiSmvrCf1kqRrxZo3FfoZueeYQFvuXjAS5PAywtin03O5oolhcz9LZd+w5kojG0J8yhXyVMcfwybinbqBMPMuw2U8fBpEhsAJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VI76M3Ep; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=VI76M3Ep;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkmt46qpBz2y8m
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 01:59:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zoQnvWJcYM6jWh3BQe6fMcD0McD2eFAd0RK9LMhbgHY=; b=VI76M3EpiySAxSb1ktCPMFl917
	uGZxDz42m2e5P2fP7pidWvO7Wh91SdvBCOljjulFseWXX6tiQ2g6wuDFWE1eo17x9qY//kI7mw8vF
	8jVzOcZtbAeRN7ai/O5RETKVKDl/HsytB9VartMxeDI4gpXwJ8nD45ynQpdiXx1GGRr4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6VYc-005J7m-OU; Tue, 15 Sep 2026 17:58:54 +0200
Date: Tue, 15 Sep 2026 17:58:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <a132b7f1-67db-4dcb-bf9c-39dbcf7d8e04@lunn.ch>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-3-prasanth.padarthi10@gmail.com>
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
In-Reply-To: <20260915013110.4780-3-prasanth.padarthi10@gmail.com>

> +&mac0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};
> +
> +&mdio0 {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

