Return-Path: <linux-aspeed+bounces-1633-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9D8C83030
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 07:37:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYQTH5W0Fz2ynh;
	Fri,  4 Jul 2025 17:37:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751614659;
	cv=none; b=gl6ellCd6VzaTlBpwVdiIIAUvWx0cX/VyQj7OVRanjyixP4tXcMJ6rAceEZoSBRE324pWY26BWP54n25pE7Wv8IExeIAg6QUfVCj3uGwV5YBfYZd8mLpRfOV43dtQ8kYGevZoltFzXtE9YBFQ69AxiNzJrTgNPQihqAMT5ttu0I6naRoybI9/DvpSocGi5zJB3pbIhzq7XKaOABj+J1rulKWyE5xTPKg0mig5cGlv+d4za8ZpTlPv9jwj+9OyFmP35jB5nLsal36hZYate6TsgSXXMPi50wSYQDKpD9RCqLRjGG7whnoVEtIyAetwrActBUY5F9/k0HirfjbFodOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751614659; c=relaxed/relaxed;
	bh=BBUFPfqcb5RmlLprxF2vX8GSwab9JKWQEi3JfpeiZSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jemGbFF/hSYclPQ6etwqiHWm//dGOU3dGE0o8eciOtoiKY0ZY8/7sw4TZGyBBPhygI565ABe26TduM4FYQJb0xniOOg5RAKuLYHiysGPGp1ioqmAZXjNPSTzQZXceXM5gCJ+0Liib0haNMqh/8rdv6m1Ds9b8OEZ5m/ykmQo+LuZZgcmKmzOiORwh0kAxJA8ypFHs7nb3ecqb/ZK0uMto3JlcI8+4Q+1BP4l96B5zBMjYJjF1rfnNR3YyQG5Ih4GgaAmcxl7iHDaO2w7B8i8xTUZdIb/tcL1fCem1FSRDXVTbJKLIZU9U/iqnM9PDhs8Cdzm4NQrl+vAFE+IiKpg4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u6rduk2c; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=u6rduk2c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYQTG3hYnz2xQ4
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 17:37:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BBUFPfqcb5RmlLprxF2vX8GSwab9JKWQEi3JfpeiZSg=; b=u6rduk2cLDiZJ613kl3yXRcvou
	PluTPpMFX5LPyyLMgyVmlIndU0nfNy2cm9KDz2Wd2FO5PUiCTPKRsZuws0DuvHXgUEHawd15w6KIU
	tc7vp6WuCc8gqz7fU0EnlPHx8g2VKDt7KEhR9C/7DTrG58Rv9q3gXw9gWvolr+g+AdwM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXaz2-000B1n-IZ; Fri, 04 Jul 2025 09:37:20 +0200
Date: Fri, 4 Jul 2025 09:37:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Message-ID: <95ff4056-d1cc-4564-8c44-0535196e7428@lunn.ch>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
 <20250702050421.13729-6-rentao.bupt@gmail.com>
 <a6f6966b-50ee-4b4f-9422-96c6ac9391a2@lunn.ch>
 <aGW8Nm8ZWMwRYVOo@localhost.localdomain>
 <220ac6c2-8373-4742-86fa-f322d6ada624@lunn.ch>
 <aGcBEHMEyQJuzmjj@localhost.localdomain>
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
In-Reply-To: <aGcBEHMEyQJuzmjj@localhost.localdomain>

> Hi Andrew,
> 
> Got it, and thanks for sharing the context.
> 
> I will reach out to ASPEED offline to see if they are actively working
> on the MAC fix, or if I have enough knowledge to work out the patch.

There was some discussion about what needs to be done a couple of
months ago. Look for emails from aspeed and IBM.

	Andrew

