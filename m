Return-Path: <linux-aspeed+bounces-1010-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06831C282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 12:47:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGZWC4LGWz2xDD;
	Mon, 17 Mar 2025 23:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742215655;
	cv=none; b=Ivr3LHjXFtIFpTGx1H9HwC3p03yfmobRYbNlf7cGtOON/s0aXqVETXvbsFOTLQ7P9O2LIuKSyL6Wwq2XqF6w+gS4wQ12yd3TCXJ0/C6Ajb4w08b4K8aO+0BnCjs+GmuqXaFmuZv1Mz5SCsLMZk9twpn1puELpGDIjnPQBNc2iZ7eOX6XNAGCqT8NeDGkeQ55PMxpBQvkJHmWsXXscIVyvWJci80TxVotTztYUThp5IzinX0owrp4WUnF9K14E4nevccm408fYIE3/1TencarUNdYo87Jq0wWhCDI9QZOQOWwGlSruz2E9d2o3qSk31uEUqxQ4iMvbq9xfuCh3/yZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742215655; c=relaxed/relaxed;
	bh=iNJJvO2bu+Nx0yChJk+GIzP3W85ueiBmXIziZPYbCvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOHdE9vZLDUWomVPS6+XPs1PAgDBkP3vrC15dhvp4VtUup1pWlRYtga37RjCTuZH9bFDZRewHl9pJIn81CqVQCQxm3bPwP8/B1JUBOKlMUeOPIF2NU3lkpskh02bgBrFcdoB4tRSvt82Ij1B9bPV5CumNqklZnJUK48P4QYV7I6GzEKdqGL91fkq3H7iq4sJaeZcP6+uP0F81/Uy1kPTr6ymTZiW7NU468efSrjzq5ukvGewVFAvwTgHgSNBDv04SPRXu3Hx68Bzz+U67OJ2nhcVqe7DtOOXNAQT6v3XX0jP0Qe95RaKswKGdVcWaJAnT/x6qROJxzaLMTmsgR3+wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Wic+sbb/; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Wic+sbb/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGZWB5BLqz2yhW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 23:47:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iNJJvO2bu+Nx0yChJk+GIzP3W85ueiBmXIziZPYbCvI=; b=Wic+sbb/02D7n4JVfpFeqLE3P+
	pJCxgsOJ6q1oubgXB2N9KrMuybB2/ntIuk9/EJjFchfkwKbMrUbp4KIE0AcSdg2AAdT6RG4KINigM
	gQ+E6izf3ww2MqXiXoSl3Jk9LjpaF/LKWWSZJp9CQVDESAe0RJ4G1QfFqlIua3aGlPkw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tu9sC-00683V-Of; Mon, 17 Mar 2025 13:47:16 +0100
Date: Mon, 17 Mar 2025 13:47:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, ratbert@faraday-tech.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com
Subject: Re: [net-next 1/4] ARM: dts: aspeed-g6:add scu to mac for RGMII delay
Message-ID: <be284777-978d-470a-b38c-2f79a1d76134@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-2-jacky_chou@aspeedtech.com>
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
In-Reply-To: <20250317025922.1526937-2-jacky_chou@aspeedtech.com>

On Mon, Mar 17, 2025 at 10:59:19AM +0800, Jacky Chou wrote:
> The RGMII delay of AST2600 MAC is configured in SCU
> register, so add scu regmap into mac node.

Don't you need to add the scu to the binding?

	Andrew

