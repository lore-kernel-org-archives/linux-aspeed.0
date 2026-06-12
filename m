Return-Path: <linux-aspeed+bounces-4247-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B232FCD98CE
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 07:04:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc9Vg0MfVz2yhY;
	Fri, 12 Jun 2026 17:04:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781247866;
	cv=none; b=NRV/KQnDCZvVylpbqMLITEklbqQ3OAsQo4ntCFOlAbHvqhrO5rfqRvolV4DllECGqaeqMMcqqs201D7SGXwUEnam3GIyrSiEnk8g4D83WWKh6q6DSoXRkP5v+ty+4N47XLNZ3GZ5GrdNN/mFNIYGLvYp132414f+s19LVbLWK0+VNF8bmt/Qz1/sWj0kMJyYdFGTvp5xWrOD/iqds8jG4WUPtIqhKiBHCx7njK1nUKhXmSFW5wv+2/iMYwAmWCo7IBNEmP6EXoq8d6xV+H0VgIXmGJNCXJv2rUMPL+cO38cI0hNKoM5UNn7x7upA51lCA1rdNYHnWwdIS/bSko/2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781247866; c=relaxed/relaxed;
	bh=q58Br9cyLJr5mgSZSCUbf47rrGbOeR1q3kZq91cin4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3CFAETC2IO5N5NSqioMQ2dAHGRJG1T3U+meXtAMu2elR4cD3pIqI1OaqxdPmuB7HyeIHWnvo5nDiFfKHwhejRsoaSgBh8Xqv0PmjzSNEWss6ZPtrT4Zd+waRnfCnKylbOhKZUi33zXXtIMP+0UVUuTeCNKsfHrVvfjNiozZXPnbZ2t9jroyGpAFo2BOH/KVVkIq2Ds5tSliQJ8DpcZp3hq7emgVHktw2PxTozFQrLMwBjYBGQg03nOt8ZOwAQAR7Wsa0T/U/G3xaRNJfkvK/xbe7imdsb6Wk/etVqFwiBsCWWbpJsbxl5A19wSWg86fYk4tuh37LHzVZGqgJtD4Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PUjiF3GO; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PUjiF3GO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc9Vd3NQhz2yd7
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 17:04:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q58Br9cyLJr5mgSZSCUbf47rrGbOeR1q3kZq91cin4k=; b=PUjiF3GOr6Sl8D4so7fIzjcB+7
	OOOXo2iv625TlpqzdjbMa6VMNyHE9ZxEkdpCpzsFqTK1DAH1jNFm79ShgwHdJyo7rlQT0jumOuZF2
	k6xtgbdqNa3y1M5Wm2QynafcicgKD5tCbXb7qXSTPt32rkoOfRjMAz3uOc/So+PxtSjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXvw1-007I5V-7v; Fri, 12 Jun 2026 09:04:09 +0200
Date: Fri, 12 Jun 2026 09:04:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
Message-ID: <1b10c279-bdb7-4901-aa40-bca36dcec350@lunn.ch>
References: <20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com>
 <20260611-ventura2_initial_dts-v7-2-a61d8902bc5f@gmail.com>
 <843dc0ff-a504-4237-b0f4-d92be07e2465@lunn.ch>
 <CAF7HswOi3fPMFppPoGmh0QELiPz4Po4cyWuDrEHLY2vNMyKE9g@mail.gmail.com>
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
In-Reply-To: <CAF7HswOi3fPMFppPoGmh0QELiPz4Po4cyWuDrEHLY2vNMyKE9g@mail.gmail.com>

> The EEPROM is physically isolated by a hardware I2C multiplexer.
> By default, the mux connects the EEPROM directly to the Marvell switch
> for its routine operation and configuration loading. The BMC's I2C bus is
> physically disconnected from the EEPROM during this time.

I think some comments would be good. It was not clear to my how this
works.

	Andrew

