Return-Path: <linux-aspeed+bounces-3575-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2953EB3624
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 17:48:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPmch63Fcz3bn7;
	Tue, 03 Mar 2026 04:48:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772473700;
	cv=none; b=XtXZOlwspBnvLrL5CffAns69MWgyeu6XBwzJG3PM9wP4xp8Oj1++K9rOVb0Yonk3urMCp74uMQkAca2YhllHzMtzOcF8dp7zlDoHAftE6kQyT3GKm6Dq9RzRSO9SMleoHnN8zEdFV+Xb9s+Tw2rJmgxVjIz/rxLtxuGwEsWPGg1vz+FR8x2C5dlmnkSKm3kh9xl56FKo2pPXmFZKatqGL+H0BX8KXFdpv9E/RdWo3lzGa+5bCiD0gSL0IeV4zGBk7lGMm/uhEo+sGz+d14UAECkx9W3cwOzuQ9IRmwpeQngzVYV5M/7XtKrCxk86DYvHXBk5PcsINGu1hXyJbtyQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772473700; c=relaxed/relaxed;
	bh=l44psQATQO9zmL6QLOShbiPUK8IKCYLpPwQa89pfI/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV77wjjfhqOimujObkyqu28+0xX/VUh7STemf8Nh/q4WZF3xLDJGQuP0KxPUmnrF8McNNNsd/rxzO03zmGjjT7V3nWhYBGGPYXiKfN2nsZx3Brr9Stt5TQyPkfUXqs5jeWIsFL0enIwyyhpKqWekt3/sWx6ir2HkM6pPKyMW2wDXyNBIJlMdY0Vhj9ixe8BRdTvM6nejS03go+fqqrxY+JONPszQXxmiAwXf5qOLaq36cO/8RabK8FvrdlBfV3DtqwbDtyCbyqlRA1dh0Ht+ZPe/v88Ik/qsIsX0nhWUfNY/wOdINn+2Y31hXN4Y2WVUz+G+JO3q5lkF8UQ/ja3r4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=yc+H6Zji; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=yc+H6Zji;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPmcd2lmlz3bn4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Mar 2026 04:48:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l44psQATQO9zmL6QLOShbiPUK8IKCYLpPwQa89pfI/8=; b=yc+H6ZjidpQuKwoJselYBw1eQj
	ylaqMBiAyE71KBJkJqF6MvYpO3hQA2tP383M4LqfOcyaD582Qga6l9oEm7CEHFAPh1eA+QcTs7Ry6
	itiYuOXZj+bC3PgvYWWZy9YrXqdcyUFxchExa/yvvvC1MWFDuxEt4Xk3AUJTO5W8lmAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx7Mn-009iUa-7v; Mon, 02 Mar 2026 18:47:37 +0100
Date: Mon, 2 Mar 2026 18:47:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v6 3/5] net: ftgmac100: Add RGMII delay support
 for AST2600
Message-ID: <ae88d56a-04c9-4a50-af22-5e439acd59c7@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>
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
In-Reply-To: <20260302-rgmii_delay_2600-v6-3-68319a4c4110@aspeedtech.com>

On Mon, Mar 02, 2026 at 06:24:30PM +0800, Jacky Chou wrote:
> On the AST2600 platform, the RGMII delay is controlled via the
> SCU registers. The delay chain configuration differs between MAC0/1
> and MAC2/3, even though all four MACs use a 32-stage delay chain.
> +------+----------+-----------+-------------+-------------+
> |      |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
> +------+----------+-----------+-------------+-------------+
> |MAC0/1|     45 ps|        32 |           0 |           0 |
> +------+----------+-----------+-------------+-------------+
> |MAC2/3|    250 ps|        32 |           0 |          26 |
> +------+----------+-----------+-------------+-------------+
> For MAC2/3, the "no delay" condition starts from stage 26.
> Setting the RX delay stage to 26 means that no additional RX
> delay is applied.
> Here lists the RX delay setting of MAC2/3 below.
> 26 -> 0   ns, 27 -> 0.25 ns, ... , 31 -> 1.25 ns,
> 0  -> 1.5 ns, 1  -> 1.75 ns, ... , 25 -> 7.75 ns
> 
> Therefore, we calculate the delay stage from the
> rx-internal-delay-ps of MAC2/3 to add 26. If the stage is equel
> to or bigger than 32, the delay stage will be mask 0x1f to get
> the correct setting.

Please return -EINVAL. Asking for more than 7.75ns is clearly broken.

    Andrew

---
pw-bot: cr

