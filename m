Return-Path: <linux-aspeed+bounces-1818-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9264DC83F1A
	for <linux-aspeed@archiver.kernel.org>; Thu, 24 Jul 2025 00:03:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnWSM2Kk3z30T8;
	Thu, 24 Jul 2025 10:03:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753315427;
	cv=none; b=JZ6exVMvA/0lyQh3j8af/dBeVAlNJZbd2rJ7lcM3Fq//c8uyBySpJ+ZqkkX1gWUHIK8182XfHiP2K4cRS+JP63OKgAjtX+jtFOwdcGhVzgQ6iqwfBLgv0QkJ3Dq7GvURdEEWYzardlwgadEIpG7qdS3uXTFa9B6f1ts9ya4rIOgXAiLIhLODZ0r4Q7+o6Xo/JfyU2l5OI0M3A/XhL4OUr+u9hy41DpKQmft+3w24fNbB2GrCarz3J8XxOLF92sBmvY0rTJFNZmqR9Qo84mT5Z0U1TL+Nzf3f+ACaNNa+Lr3n9eRRGEgzSugwEdvOn9kc/4BVcoaf3v1GILcCqpHGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753315427; c=relaxed/relaxed;
	bh=wdMyNpyczdlOF7zghQKC0llIb5aOLp+CiZl88HV1/CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6F8U5Obi0vLnmcN2aXgLgzomtIlY6oC1OoU7xEGOtZOOljRFWofQjxY7GLUXhv7fkDGK8PCbWp/64aLXcY2vOO9xVG7/8chq4F7Y/9LhdUj5BmecbWID1ftJyfBwHSKe/H/vvgKI7RQP70y+zfTR0pU5Q7ge3jYYlkGz+Lx3vYMPMOClzLrx9HmGmlQg6GNR0gVFD70RFyPvGD053GWL/gG4R57M46bCTZoIO/HHVrLQ+siaWR1ReHAKG80XkKVQXKiz9cTP3WsxkRktV7gWvLmMjwBAEVmWbOEJBT5Mr80gowzAwas4R/krEk6MI3mb6lhMqSVu9OHzCXYXUSEbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FFjMXEE0; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=FFjMXEE0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnWSK6b8Hz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 10:03:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wdMyNpyczdlOF7zghQKC0llIb5aOLp+CiZl88HV1/CY=; b=FFjMXEE0dft5Mn5To34aMAJvr8
	FHxoLBZ+8iDP57LHB1cR5amgeViOAMJdI0zlKqag8LggouCHo55dVo9BBj3SgM/KamWMM6K2Fk0Cd
	kDuszKOEo5VSLCKafxlGKhsjfMOevUJP5Md+PFzLd5xH5RdqPMbiO++iN42cyFe19FGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uejQf-002hyY-0O; Thu, 24 Jul 2025 02:03:21 +0200
Date: Thu, 24 Jul 2025 02:03:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rentao.bupt@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
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
In-Reply-To: <20250723233013.142337-11-rentao.bupt@gmail.com>

> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";

Does the PCB have extra long clock lines to implement the 2ns delay?

	Andrew

