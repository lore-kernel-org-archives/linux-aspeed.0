Return-Path: <linux-aspeed+bounces-1839-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CCFC87FCC
	for <linux-aspeed@archiver.kernel.org>; Sun, 27 Jul 2025 15:46:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bqmDT5VCcz30W9;
	Mon, 28 Jul 2025 01:46:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753631177;
	cv=none; b=hKFibPhHVzGzWAbyQuug57PrDL18xbpB62iZMhinq2RMtPEMxx90zoIJmszQZDOkS7lQ03B1dDcECxFDPzYwMsjs1k6b8ZOdmeiQ29VEfdO8NtcfJtnFHbQF1zxqYIFe6baI3rlmMyfzOGkwDGQq/UJUIv2fLcrzefUSV6c/QaOK8ZT9QTmgrDkFH6Z0E/rEnUyLbSb99K/2VFURTZSpkRslaQ5enjwTmlNz2PnDtOfgyn9gqcJz/zmTFXrr+TZTSQsZK/lXxGw9+rTtc2nxYitcyB3kVJSXExiaazQXPbIdODV6Izq98nNa1ypDg5J5DqPnC8W/Km0742Ef4byv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753631177; c=relaxed/relaxed;
	bh=ea/LVnrickzrKsQYDVPNFYq4HqocG3+kI8GD60vgLes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgoAmFq1ZYJBkXy3TqzIMDSxPl8WMkv5l2dftoJE9nrGluBZbLmh2qIwq9vT28WZHM6OkqE/J9HJdIwoOY+iScLSCVX/cT0wMY5z1Z53p4jLg3LFsQTFKE8GUdWtkLmRS/Z3jC95RBvxXZXaZGuO3ddU1OLzFvyhEQdskQ2Xdnl4IkgUiS3no+otIAxiOpXu5t+L67KRETo7z3HKVWQtEzYneamuTXqt2J2DoCtkHIuw8Niy5v+3wB8piatVzSUKt/aV7b5uTtl5lwVUPj/7Ep8X4+5Z5UFwR7+ZhkR/iue7idPmIVZuGTgPiYk+fU+K07Pr2MTKDD4Cmc6VtPROaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QBVi0/B3; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QBVi0/B3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bqmDR3jfbz2xjP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 01:46:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ea/LVnrickzrKsQYDVPNFYq4HqocG3+kI8GD60vgLes=; b=QBVi0/B33ltuEPuvItV2c342JE
	VhGgUB8pE0M8DhPFgtpP/R0NyKeM5ckeok09OTTsnJ7nKRsFaN2LxdVWS4bu1Ir1Ma8YWCLfb7W68
	XwcuvozrF4T6aKh7FDl7mf5oXsKSz7RSs/QC+PGWcqvrdgFZpND3OkPMsKx9aJURUxpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug3ZP-0030lE-Nq; Sun, 27 Jul 2025 17:45:51 +0200
Date: Sun, 27 Jul 2025 17:45:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Ren <rentao.bupt@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <9897e0a4-7c70-4e27-8591-09e9d6ef2263@lunn.ch>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
 <aIMTvUyHGd/ikKY9@localhost.localdomain>
 <aIW/xEfJX/UD1kje@localhost.localdomain>
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
In-Reply-To: <aIW/xEfJX/UD1kje@localhost.localdomain>

> As I'm not 100% sure where the RX clock delay is introduced, I will drop
> mac3 entry in v4.

Many of the hyperscalers, or the supplies to the hyperscalers keep
hitting this. The standard policy at the moment seems to be to drop
Ethernet support. How useful is a BMC without Ethernet?

If you all got together and talked to aspeed, apply a bit of pressure,
it should be possible to get this mess fixed pretty quickly. And then
you could all have working Ethernet....

	Andrew

