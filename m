Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BF606A333
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uBMeGJL4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCtRS4YJcz2yMK;
	Mon, 26 Oct 2026 23:36:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793018212;
	cv=none; b=d3+cPm7u3w+FCl3PGM15x3xqZ4IVWf6wmUTT8W9wzHEZ9b2yJ2f5ig6jTDY5cuC8Pb3/JIrWNI4e3dYkFECIvgjHY2owfrm+6h9Z8SkNYYSf+7JFb71Tw7QA6Kngi00IFTXfvIlxo6JFLSGlt7ZIa7wWjr49Qg/Zb7NpEW30upRcFmLTEF3juwrcxxIsd3sAwz2mw8wcNFOuIsY3a11A5BWxOHGM9Yt/wbi+qq0tqI2gtj/vA6JmRGTz//sVG5IF+VeCJiUSzJI8j4b9aWst7ZFnY6ncT7ZRd7QhxrqYoEFBXwBCkc6mk82/zBxdYDJ/F2GDefDLLqoToKl0jy+hAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793018212; c=relaxed/relaxed;
	bh=lIwfX39/1xU2NA1XZwUTvUajjOaDvuDKqu8wPxFYaZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9bmrlGTcQOAgUpo9syGVVKOq32tQWkrgHHxLoqfzL9d77yIwbRpNWUjLTZyhtOydq1QZosfjmAyRK9lO52UWzfNe+RAfJ/UzLZRhJLt+mZo5cg/0srUibobo6ng32hmxZTnzd+qLhvuASDbz2JQz3tc/3LORSgaSGCutxv8Hd+vb5FX/INsqVC+BalDiS549yDi05NwrK++03nock+bwjvLi6ANP6Sp2QufKCuH4RFspPz12mpVyG7y1G5WmohA73v7vWUJOoxkPxakQY0SfVcWlvBEuFqO/aQ3FVsIO2rI2MjQys7aW1giwNXw0P7WRSGnMqtsLDYNWa6S7POPdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uBMeGJL4; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uBMeGJL4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCtRP0jwWz2yKp
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 23:36:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lIwfX39/1xU2NA1XZwUTvUajjOaDvuDKqu8wPxFYaZQ=; b=uBMeGJL4afAOvzwTx3cTjiA5jz
	CzZF53gUcYSEEsWw8kW70v32vlp6yJ0uKq+n+GqqsntmJ3kvMuzA4FKG4UDJpifhPr7Qz/w7AqAvH
	WVwgVz/OflNGm4uJ41Tfopvv6Neh/+bgDm7bC7GFhCw/CRcsqkmi5KYR8ve357yIMabI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLJwE-00CnRx-S5; Mon, 26 Oct 2026 13:36:30 +0100
Date: Mon, 26 Oct 2026 13:36:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: KAVYA M M <kavyamadarsh@gmail.com>
Cc: Prasanth <prasanth.padarthi10@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <e33a471b-5f4f-492f-9656-e19e0dbfa1b7@lunn.ch>
References: <20261002062933.26497-1-prasanth.padarthi10@gmail.com>
 <20261002062933.26497-3-prasanth.padarthi10@gmail.com>
 <CAMFFDGjmJTRR8GOX=S+kKnMA-bG+gbZP0sS8dG_d+taDPPRDZQ@mail.gmail.com>
 <CAD_a9mYKSYyP2TqeyjbQWYHdZgF3ggdrU6oTK6VWs2C2GSYMjQ@mail.gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD_a9mYKSYyP2TqeyjbQWYHdZgF3ggdrU6oTK6VWs2C2GSYMjQ@mail.gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 10:04:05AM +0530, KAVYA M M wrote:
> Hello team,
> I am new to OpenBMC. I want to development image for the machine using the
> OpenBMC/Yocto build system, available firmware information, and readings from
> the existing BMC.

FYI

It is considered bad practice to hijack some other thread for
unrelated matters. Please start a new thread.

Also, don't top post. Netiquette rules apply to mailing lists.

      Andrew

