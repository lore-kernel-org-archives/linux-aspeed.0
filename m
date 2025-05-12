Return-Path: <linux-aspeed+bounces-1193-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3ECC3ABD9
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 May 2025 13:11:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zx0PT70T2z2yGx;
	Mon, 12 May 2025 23:11:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747055517;
	cv=none; b=SgOhdeNxPcdJ9rwMaV3y7RzPYHoqWfX1fFynugchiN2Th3iAYByGqy0A5kr+yiV+Kuho+QfI2CQXOEiBcLkdGclWLPbU5qB3NHUmUiOla2zBYbYFByq57NaZtV7LJpZJgtOK+7Eb+m7+uO0u18gbG86hUfwr9Obb2uDpBtKzR0EWYlvqIsgu7BPmuG5LPyKZ0RoCxOxBQkEv73jjOJ+SRcRM/gcMEULFTmh1OxcH+zRJFc31UFCz/H1yu318YVXgkHiwnLPZg22TnV16P6LDZcG3l42fXZHzFfDvMw8QORHl3Vm1ZJCwuUvdLl11soEnjWmeAFMx3s+Cc7jttu6BSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747055517; c=relaxed/relaxed;
	bh=lo0m91Rehd6bgZG0QLkCun4bgSY/wiPJXWGmO2i2Vw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6OYYapTfQioGvhyNqOTap+dztIAtYPsl+kuSxRpfHc2cQe45kTMWeU42F9q7vmnTsnOX9aY9CchAILJTMd54/Po3L4wmkXc7aYu+d02k9ljWihz5AiK80nivxYH49NoNGylaT9/b0IjhvcL7y9d5OiZRRzP6a8Ak9gAi6m/YkjAGpkIPF+FlhtlBhaz1irLYVcEqiII0P+zYwjQX8pUk1vxUOn8KGuT3XNWnvZdsZPb7JRmyCEP/K1wRw3Q7K5n2vJ0mdN1QYTuDDJz4GXwz1lFtxeFtWXsOSkTtVN/8cFVyZdoRq1BGHmZ7Q2JTm4idLGGr/4r4xcWMKhjAiM6Ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dMHF7P12; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dMHF7P12;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
X-Greylist: delayed 1881 seconds by postgrey-1.37 at boromir; Mon, 12 May 2025 23:11:55 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zx0PR3Mxcz2xfB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 May 2025 23:11:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lo0m91Rehd6bgZG0QLkCun4bgSY/wiPJXWGmO2i2Vw0=; b=dMHF7P12CyWbyi6Lt2DBaFT42h
	UltO+mXfugcoI/aNx0B9AUqY/vj281F7eA0tuVbbxFob3Mxi1rAgv4eFf9QwBOVxAqZGQmn8Ebx+k
	eUpy8a5Lm55lvr5ENppTsMzEEhQz3pz9bMaep8BP/CSOWJojFgmdixn2M4Vh7GgaYRQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uESS4-00CKp0-VS; Mon, 12 May 2025 14:40:12 +0200
Date: Mon, 12 May 2025 14:40:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: leo.jt.wang@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	george.kw.lee@fii-foxconn.com, leo.jt.wang@fii-foxconn.com
Subject: Re: [ARM: dts: aspeed: clemente: add Meta Clemente BMC] ARM: dts:
 aspeed: clemente: add Meta Clemente BMC
Message-ID: <224aec6e-6dab-4634-a7a0-220616f455de@lunn.ch>
References: <6821dbe7.170a0220.3b15e.ab77@mx.google.com>
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
In-Reply-To: <6821dbe7.170a0220.3b15e.ab77@mx.google.com>

> +&mac0 {
> +	status = "disabled";
> +	/* phy-mode = "rgmii-rxid"; */

This is very likely to be wrong. Please see:

https://patchwork.kernel.org/project/netdevbpf/patch/20250430-v6-15-rc3-net-rgmii-delays-v2-1-099ae651d5e5@lunn.ch/

	Andrew

