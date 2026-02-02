Return-Path: <linux-aspeed+bounces-3459-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC09E73174
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Feb 2026 13:48:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4Sck2XDGz309y;
	Tue, 03 Feb 2026 00:48:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770040102;
	cv=none; b=J7JFVJ9cBjfAYxj6XknqrFR5CeVTAdbZbmr1R+aJhC3GHZ/iUD2zCbFa3/qpEYcD0aQuAuREbpqjwVze0y+TDf8R9qIM1ajXr+rg20rGe122ckZ7Dd5KM5N+XNhI9InPW4FFR08YYxIyismcvTJeYN7ICaCDV6TiSg5DkY/GXIN6NKahGBp0F4BiWeZMD5o7p4UtBZdbzROj1tnsKyGi7vyOBCMFn2vwrD0lDQC8/F7QKbzyRD8PN8odunqppmWyR1PmbkU4BDSuWUa5nQTUhSJ7sEfc2CSCsIuY9BXpod5vHSp/n/ZGp7lFKx3swOoRPuTVdM1ZwGH1061pMqDU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770040102; c=relaxed/relaxed;
	bh=X+W4ZDLYcf6XvV35qGRdJ2by5UrE788TXg75U8Ga6uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIhTpNolmKmebgnD5PfDbFaKfbMHncKW9Fgy/iHWf0r6kbPF3v5v0AzMSsrDZRtWJh/PgsOXVIwJUTfpMuIdhemTnWn7t4VDof8BnEoWvIHfDzDFzjJP6SyClOS6p65ldq/fUDUDNbb3Cu+k5RQZOYrLNyiBfi94rB6vNe7LCMk6+e2QOTR7XpOqB6X92rKygbsn+xVo69DHrU6IImUn4s/pU/bGbeEvI1Tk+DwLTQ9lt5VSbbk2NitjJIO+/topq11cTWlqPs7XRs2Vsbuv04w1veTTUUypZbqE5K0MkoEbyDqzwT4tl5/a9bF16uC25gd8cB+BXn0zGeIzYVaqPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2QWGKoPJ; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2QWGKoPJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4Scg72cbz2xpk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 00:48:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X+W4ZDLYcf6XvV35qGRdJ2by5UrE788TXg75U8Ga6uE=; b=2QWGKoPJ2dAa9pW9Xt5Zq3fFv4
	SU7V+M0neu1dlyJhZWMRE4xDPaIh/aZieM5DZ5TdnLjo+dqGh2QhY/SwYQvTyaERz/U1kgOwM42BQ
	TfTp0li/Sx+zhZR2MDB0zTSBjDXhMmsL264ogvK4/XI/45oPqoSzxCT56vNFCe9Bf5wM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vmuHR-005pVE-A3; Mon, 02 Feb 2026 14:47:53 +0100
Date: Mon, 2 Feb 2026 14:47:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
	Mike Hsieh <Mike_Hsieh@quantatw.com>,
	Potin Lai <potin.lai@quantatw.com>,
	Roger Kan <Roger.Kan@quantatw.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add Meta SanMiguel BMC
Message-ID: <902ccda3-d5a0-4a8b-8bf0-afda3a2cb1af@lunn.ch>
References: <20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com>
 <20260202-sanmiguel_init_dts-v1-2-c0023ae41899@gmail.com>
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
In-Reply-To: <20260202-sanmiguel_init_dts-v1-2-c0023ae41899@gmail.com>

> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii-rxid";

That is an odd PCB design, with an extra long TX clock line, but a
short RX clock line. Please check the schematics to make sure this is
correct.

> +	max-speed = <1000>;

Can this device do faster than 1G?

> +	phy-handle = <&ethphy0>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +};

	Andrew

