Return-Path: <linux-aspeed+bounces-1856-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02E9C87FC9
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Jul 2025 13:56:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4brxhW3pTQz2yLB;
	Tue, 29 Jul 2025 23:56:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753797371;
	cv=none; b=VgFIq+GNsa4W2i+tAu9zzv3qjsLZbG2FTixrNx1JRlir6BY5hA154WAYaVrjJ2EWajXvMOKcGbPMl1End3Wp7OOwr55KM6TO7xYmCbnHbOAsGnPOByvhlYAqQ+RlkjY4mpICpCf94er1GJzmVxCUkzOW3VUytyipdozq1FJdUb4JtKhiBVatLQd/oTjkVP0Co3Z4h1Ak5Cc8W8ttTot7yEwqizezq/3hBJoF3HRxZTqCb+pOBk93F1hfkreXtxyViCJcE319X3kvhDDEqpxCBAkLPrCy4Mmt92nzuo5NlRmAw983orGrvGmA08DQvoyc6uFuqTFfRmuxCvXIGXg7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753797371; c=relaxed/relaxed;
	bh=TQdxKKVZ1GM7fhQqDu7S5KrsXU0ul66dbGYdSM5AmB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpaJ1mp9n1MPljrBMJZo47X45P7BNzmidUilQESA3m0580fhk3IQ5/BZHUg5irsTFoLfJ+GRyTgZbouLvtWnLmuioZG/Jrmw9yz2FNq5SecrNTadwSGEYIKDz9O74fojXC0buwXLsvRo9K6LZ0N5Jmd3ApKxchOa5U99mAPof6gYzvT97jRFmAk/GjNzf0CNTzYnG2CB4uQ9//lZ0lt/1hSRo93kumuyUcwN8iKO92m+bJKQbMd7mu7zHryEaeZsCeJgXwBbInNyUrfXTZno1J1vvs1oHKmHOEP4PxslQGrDBKEFfeIpVY48T90g7kdfw9JIUEtPEBfshL1YpZKlwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JCYskDSC; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=JCYskDSC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brxhR5TtLz2xRt
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 23:56:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TQdxKKVZ1GM7fhQqDu7S5KrsXU0ul66dbGYdSM5AmB8=; b=JCYskDSCGBuSczNjpjsQY5I19S
	KpaMTZOPRKIXZthIe0Ra+XbS+f14yNgQyF8RpCcM5UssF9/mKrNKvv3Fb3Yyv+m+qDKbiJsklw8zE
	eSBvljolvU6qo5fWYda0ckU8D4odrrnb81PLnQ48bG2eMZqCjwGD/vxbOl+vXSTo2Qq8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugko2-003CMb-PD; Tue, 29 Jul 2025 15:55:50 +0200
Date: Tue, 29 Jul 2025 15:55:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fred Chen <fredchen.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] ARM: dts: aspeed: santabarbara: Adjust LED
 configuration
Message-ID: <bc6b2174-e7b9-44c2-8232-51a3accff2d0@lunn.ch>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
 <20250729091351.3964939-4-fredchen.openbmc@gmail.com>
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
In-Reply-To: <20250729091351.3964939-4-fredchen.openbmc@gmail.com>

On Tue, Jul 29, 2025 at 05:13:45PM +0800, Fred Chen wrote:
> Add a new power fault LED on GPIOB5 and relocate the ID LED to GPIOQ4.
> The ID LED is now driven by the CPLD, allowing it to reflect multiple
> system states depending on CPLD logic.

It would be good to add a comment about why this is not an ABI
breaking change.

	Andrew

