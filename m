Return-Path: <linux-aspeed+bounces-172-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B84D6554C
	for <linux-aspeed@archiver.kernel.org>; Tue, 26 Nov 2024 19:24:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XyXZZ6Wnhz2xjw;
	Wed, 27 Nov 2024 06:24:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732649078;
	cv=none; b=QasoJznFaJbSliQDuaegPIMxLPi2OsdNsN/ruYXWh/qzV0dIvtmiDJOavTkv+PlxsHF68X+hjRZNqMFKIsK8Ltmjh9ZXK4Im2iwKFoBTRzeD9Cy5h0YOYD5gxnPtHiyIx71D7vI2wKZrEgSyYlldd+GTlF/zTvIA4s+8rpu6EPPWbIMrjgAnYzuYdEDDY3+qqw43kNAZNE7TIJz/z+uQIFTBkumGtMvHrVVYo4us+xwAzAq4+Tf2oRccwMfkKExgiRwc5DI91tjSt8HspmX7Al3gfTLT8PuY0+OfZfPf2L7GsEJFPNZp0s9zCiglOY+SU488a4VaxLousmK/l+auoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732649078; c=relaxed/relaxed;
	bh=snKroQwtkypY8SdAmHkbYrAAMz7CQLXGWztiA4anALU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoAoNkvrldT69FyW9dElDep25HX7DY8pP4tWzA1jEoGdxbMiDakmD0sDame+kzz3qzEQKkfcHfAZ9T4f3fbsskPNgQIBLzIZ/mdJmWHR1v8S9c81ZlboDypLfAGSGzl0ICkvi5IW+1M4HqmNph3PPgumM89icJ91xKG/Z7H+MzOivdJ9W8AcSBRAI0rPLpKSLGy7yJKa3UOOwoX/ktKfU7C1NyRIQqzKrx6XNoC26cBksMIibo9S9OBWIuBKYDeCOBwN67Skut2q3jNRxrVyYTRBoAH6jcGbpBSFmxuYkHt2l1bY7CY6bHVnMzynFCmfPzQ3pc0J8MMNAlUeBiaZTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ut329A+t; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ut329A+t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XyXZW6R3Lz2yHj
	for <linux-aspeed@lists.ozlabs.org>; Wed, 27 Nov 2024 06:24:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=snKroQwtkypY8SdAmHkbYrAAMz7CQLXGWztiA4anALU=; b=ut329A+tI3avnKTDT9v25tw0Y1
	W4SBgQOyGBdvNGrWiPgUmzHTCs5JL317/ClnLgZrzZsdv3UAUzdYf2LAjTrxzC5Wxh2WB0TbwQxVA
	K/RXS44a8gmeHWiZE983yZfQtj6xkcnR6TdmHqlqI3StK5XZ9MKiE44y+O54/PYlSN2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG1AV-00EYHb-Hf; Tue, 26 Nov 2024 20:24:15 +0100
Date: Tue, 26 Nov 2024 20:24:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <160008e2-f480-49c3-994e-a498e74eee23@lunn.ch>
References: <20241126111817.2331577-1-jason-hsu@quantatw.com>
 <20241126111817.2331577-3-jason-hsu@quantatw.com>
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
In-Reply-To: <20241126111817.2331577-3-jason-hsu@quantatw.com>

> +    // 88E6393X CONFIG FRU
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +	};

I just noticed this and it seems odd. MV88E6393X is a Marvell Ethernet
switch. It can have an eeprom, and if so, the mv88e6xxx driver will
export it via ethtool. It is not normally visible to Linux as an I2C
device, because it hangs off the switches I2C Bus.

Do you have some multi master going on?

I also don't see the switch itself here. I would expect it to be
listed in the MDIO node.

	Andrew

