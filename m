Return-Path: <linux-aspeed+bounces-383-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC27CE77197
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jan 2025 14:48:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTSMn2cTcz30T9;
	Fri, 10 Jan 2025 01:48:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736434117;
	cv=none; b=COPToS0VqCx13xTJBl6L+X1ccw0qRY6VS92JzX3ji8U5HJ/Eum0OMPJbrPlwBXBB28CEUU1A1ZzBKF9xnJ3cjIOqJrCoMANTIDOmC4q1cXxTCaBDgh09qTzVp/5A6cvsvD/WpLj94fRlfkPEEEU5Gyd003r12U2TJWfF/CMPjXGr/lM7Rx87cq3xiHA8s/ezM2+Lp4d/nWIkfv+DHUxMhrEP7vbXrawgN5WwqIq5rYx3V2B2WY/EdN7ra+2df+CJpa3XOLYvsXZMOCzv1r8+IUI/z91JKkmvRCOMTt+VxJz9Od9/WrVmrqMYKAJ0yX+u5qsXJ/ZFIHL+wqTGoqdJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736434117; c=relaxed/relaxed;
	bh=YfjcKm0d4Vajn+h/jwMfdima+TwcpMUsitsmuyI+KwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxzWmWxAnR6dRdQRvs8s2dcIHAiKuSWgMHgZCsfN7wnugpZf1A9BeMFFfTA4p8Nn4wKUuibToqv7PBvCC5Rc+FX0wnSnNWqzGT7uhemRVLFmwW+qa38HF1BcC2qnFbIGQ/+R6P+WJ7cr9xYgFyrKoV6I/8ATePG7N/eJPc9wsHvHZI+Fc+FzHaAgHjnp6vNzsJBOm0MJ9bez4lzhGyMEH9zXNCpcHVP6Lbs4Ubx6bN9f8vIDKTmcOlKzpiUPzNsB9sSwbLAaaTJzQ0m0/ZAgqEi+stbgAY9SZ6/S+GxJrzyBK9mdfj16/nMpiANljqubgGE/+VokE5zLJudqGhUCpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mGzh0Iq+; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=mGzh0Iq+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTSMl6Vpwz2yFQ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 01:48:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YfjcKm0d4Vajn+h/jwMfdima+TwcpMUsitsmuyI+KwE=; b=mGzh0Iq+K5BiGQJKCYwFjh52FU
	8bznveg2/N0yjqFingSY3hMZhRhiI8vCLBYMpXXUpVkwspAxYT7Ot3r33BkECyz5qI+0WzMjqmqFc
	YzPlAj0bQp/V5Fg/nycCtFmwKyIZNH5f0qN5RcgXWY1eYQhNiuE/4nPdt9jR7lGytIio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVtpR-002v8k-IQ; Thu, 09 Jan 2025 15:48:09 +0100
Date: Thu, 9 Jan 2025 15:48:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <8ae7c237-abcf-4079-a4ba-ce17e401917d@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
 <6ac77e5d-e931-494a-9777-6ed0bc4aa1e9@linux.ibm.com>
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
In-Reply-To: <6ac77e5d-e931-494a-9777-6ed0bc4aa1e9@linux.ibm.com>

> When does someone use rgmii-txid and rgmii-rxid?

When there is an extra long RX clock line on the PCB, but not the TX
clock line, you would use rgmii-txid. If there is an extra long TX
clock line, but not RX clock, you would use rgmii-rxid. You do not see
this very often, but it does exist:

arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts

/* RGMII delays added via PCB traces */
&enet2 {
        phy-mode = "rgmii";
        status = "okay";

	Andrew

