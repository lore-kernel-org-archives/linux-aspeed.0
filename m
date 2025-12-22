Return-Path: <linux-aspeed+bounces-3194-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2510E6748D
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Dec 2025 09:31:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZXvN2rMvz2xpm;
	Mon, 22 Dec 2025 20:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766395872;
	cv=none; b=HdQulOnpJo97hsP42unu/VoW0ckx+uwVaFoSXf833bG2m/zRfvkNfs4Jmg0sivnN+TDpT2bfJkLaXDINivlokyUK+AmG7NVhARYOSLtX7mSkPAWSwnJknfsap6so8ochrjz9XY5DL5p3lshK5NMdJ0PzEmH0AhzY5S9WoH5nnJ3bsFDGrYiFbD7KcbAhoibgX7pqcVXOshlqtlxHoLE/GpJak1LV9LzMxeyWceIyAfm0u0N5ExDc2Xz4l0/sDk/o8JmtpO44NGOygCcwmYUb39bIJIq6XG9vlNKtQ+yPu/wDRNnIX6Uv5hoKJrouYUZOrC7rk74UBTzX+xiFOzFVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766395872; c=relaxed/relaxed;
	bh=i0YQE5cIMQ8TuSN1tQuMtY/HpGiRBNZ+8oVm3GsMajU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB3IgRkl3v1qcVyJa5LKJkgPlr6YIxz/XZk7nX9d2Z8jWHROpPyFeGu2kWRqifN/q5XxrAXQJwPPm6Y3IFN95WiVtfIionzTInDx0tgRF4mvXBKSf7E+El1kbaJ7rnm0fdj8j971ZJnSFDYBdLhnb1ykeyMQs1siqHsIBrtsKOnxq0ST0x3GVtznM1Slf/3BjME/qiufMpBmZzFsoNhhSfPZPZyI4iNfkaYn6uU/0ugNsY7cg/m+BGYB2ek6y4IV7nBJKf5dyCyGSS1hoxw7xkbqSAFvqsJ1vjVzb2q74Gx8IAkyPq8h0IDCC7TnaCxqanAEMgJv97+wacY7YTV9lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5f7el+Au; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5f7el+Au;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZXvK5DJwz2xFn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 20:31:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i0YQE5cIMQ8TuSN1tQuMtY/HpGiRBNZ+8oVm3GsMajU=; b=5f7el+Au+oY3EUW9T9yq+a5+yu
	P7p5Qb7ePDeVrVBRvhwxZf8Tc1WDgGr1h0K3L5O0Xz/riY7zjw/kcYgAIolhYGxjeDhpojGZsERbm
	I4OwMLKL5NzmJjnFJmX9o7yX72xzkxc4qf3kwj990i5acruwf2fdw9VhOLKREt0rmA7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXcFY-000AAb-M0; Mon, 22 Dec 2025 10:30:44 +0100
Date: Mon, 22 Dec 2025 10:30:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
Message-ID: <c069b452-df22-4afa-bf6a-c48949f40ebc@lunn.ch>
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
 <20251222-ventura2_initial_dts-v1-2-1f06166c78a3@gmail.com>
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
In-Reply-To: <20251222-ventura2_initial_dts-v1-2-1f06166c78a3@gmail.com>

> +&mdio0 {
> +	status = "okay";
> +};
> +
> +&mac2 {
> +	status = "okay";
> +	phy-mode = "rmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii3_default>;
> +	fixed-link {
> +		speed = <100>;
> +		full-duplex;
> +	};
> +};

That is an odd combination. You enable the MDIO bus, but don't have
any PHYs on it, no phandles pointing to it. And you have this
fixed-link. It makes me think you have an Ethernet switch on the bus,
and this connects to it?

    Andrew

