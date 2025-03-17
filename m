Return-Path: <linux-aspeed+bounces-1011-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3510C282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 12:53:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGZdS2zHnz2ypV;
	Mon, 17 Mar 2025 23:53:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742215980;
	cv=none; b=humVUeogrhdJKIMMuUBM3F8N41mk4tW8ZdSOZQtAVXJJB2aDWPiyvNqn3k5+jZlaIhcJARHnEG31mRbBZIq2RenDiF2mRqWp4wLgFRjgVKCwl4o4s6Du2CGl38SX7JjibRSVlVowjiL2P4uw0T76lPtMEkCpQq+8KvBKoc1O3NCkLO0PqFu8at59l3HqMKxIZXgjxTpkD7RzniQnnWOY/xolqItNe0BRbzaqNrpjL0snTzHTvPy5dphmVKOme1YKuQba0XKmcJNNcGs6Z8GHqgvF1k2711szlvp5iucAzKKk01DO97KnS/oCwCZiVcoSRyDFG7YNCVFlithZOfxn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742215980; c=relaxed/relaxed;
	bh=dq8TNjOCjLs57PNkzG69jW5zDo7b4i7oIyvx27qBQHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJJlo+kKEWLQIo/aXWCVcUTDmzwcnuoWWtwXwdbLbUsRBYts6lOFCsSJgj987u4Vii5bAmoVyiTl5dm5sXnHOFa1VAJP5g9snADCFtZEAtcAQk02PJ5DzUQn4+b4/EFYtMNEQyov0JPrBbF8pulG5k4PIUMCasrZ0hqs2YCk11cqdh//Jah5qulQ7T9T8ry3qKg9AJHf8EE9y1bhMEOu2vw3+H5Ju5+5D8FfURiaWrypj8OvCzoJGr5ueoS+M/UdzwDfXtJO5wIeVhUO5oXwhdxTXYpwlRg3mrGQAd5n/v3ItHZpDZXgvfwE5tapQ5b2CflxlYdnnqBMleE7wgp1Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zWSxkV0Q; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=zWSxkV0Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGZdR3TNJz2xHY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 23:52:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dq8TNjOCjLs57PNkzG69jW5zDo7b4i7oIyvx27qBQHk=; b=zWSxkV0Q5r82QAJmVgOTeKBxX2
	QlJGtpW4wD4DoQLscaef5r+m/p6377j9uwUH2+sJG2lRQB6I7jpkoaao+92cm5D/467eylsaMCJL3
	YxPYpQf11dRIFZXHQeE50Chsa3rVeV9qtiEe4T6XdNzXdxxT9saD/JiNxDAz7smLprOc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tu9xP-00689D-H9; Mon, 17 Mar 2025 13:52:39 +0100
Date: Mon, 17 Mar 2025 13:52:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net-next 4/4] net:
 ftgmac100: add RGMII delay for AST2600
Message-ID: <c3c02498-24a3-4ced-8ba3-5ca62b243047@lunn.ch>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
 <20250317095229.6f8754dd@fedora.home>
 <Z9gC2vz2w5dfZsum@shell.armlinux.org.uk>
 <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB51347CD1AB5940641A77427D9DDF2@SEYPR06MB5134.apcprd06.prod.outlook.com>

> The RGMII delay of AST2600 has a lot of steps can be configured.

Are they uniformly space? Then it should be a simple formula to
calculate? Or a lookup table?

	Andrew

