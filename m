Return-Path: <linux-aspeed+bounces-366-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12214E77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 17:04:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSvQY4sZVz2yLB;
	Thu,  9 Jan 2025 04:04:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736355845;
	cv=none; b=PDLyDZHTiyTgercbGgs8Gs7kYXqCBZsxotdpZRg4IvPJpGC6e5IAVn59+owB0zVmAnnBKS8QjSSX5wNjUjhuKQ4WbXJu6I5058WrsNqgWoWEUr0dg0xs2FqHaOcFR8VhHxPxeRlrDvVfLy7xDZzZ51RbSbd+lVKaRuq8gnQPwhJx0e9JbYX0SMoaTzv+jsX44DEhbpmDNDevAIzcuCZSQefn+kjsMpxUkD1mFBq8Q3aLrbu63xrLYdbZmv7wNwkGAbg3Uw03Xd7Y+Yw76IYYMtQP86Nz6duv8mVqFXPEyHVxzxjZW3FPWtpGEaE4ZjZKMVMFz/UJmUFwH8ejOKtgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736355845; c=relaxed/relaxed;
	bh=wElwbqEqYtg6N83+A08t0RJt17oPW/Yout1Z5OV7l2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyftMHfk1PGuTzxM+ZbVJ4Z0mhb94U46JfsX8o2dZJDhfSweKFs647mZ8ZO/zPYEk1VvfOTxnNn8BBeMsymCMkNI6f2cTRNO/yM/5cWgmBaElze7nzfZZ0HpRL0xdHwrU8B2eKE245lrWVLyuDDizhlh/ELig7Gi82hO294PkHMvTU3GMfvyLHiME7DeIKlHGsjVx8eQLyYgavkY5ZNS2fD+K817rn1KaZMsJteK8Sy3TjCkozhjKg4eiq0HhgiB6PM/asiZqBDyXXGXe4EGHPVPGkvNVLUs17hkq419+L8GVtc/iyml2AuWXcTq4ZdQW6PFrjugzZWdjZ+uENi3JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LiqIKbvF; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LiqIKbvF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSvQW6bvTz2y33
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 04:04:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wElwbqEqYtg6N83+A08t0RJt17oPW/Yout1Z5OV7l2E=; b=LiqIKbvF79gNnpe3mR8Pb6mhfW
	UUg2iHN3dn42PtoqQBxZLoknQuanz+p4cGI5ayiWZyNkAc2QBgNVh4tOsa0myHvQBxlYLd8yceTB9
	jpwfOz3xVK4dFJmDKSYzOwFtbFpKbQ9kkM+luWpmwlg41K2n0H7QiL1FgN7tkAf9DF7A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVZSj-002dOZ-NO; Wed, 08 Jan 2025 18:03:21 +0100
Date: Wed, 8 Jan 2025 18:03:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-6-ninad@linux.ibm.com>
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
In-Reply-To: <20250108163640.1374680-6-ninad@linux.ibm.com>

On Wed, Jan 08, 2025 at 10:36:33AM -0600, Ninad Palsule wrote:
> system1 has 2 transceiver connected through the RGMII interfaces. Added
> device tree entry to enable RGMII support.
> 
> ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
> 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
> PHY chip.

You appear to if ignored my comment. Please don't do that. If you have
no idea about RGMII delays, please say so, so i can help you debug
what is wrong.

NACK

	Andrew

