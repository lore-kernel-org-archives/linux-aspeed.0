Return-Path: <linux-aspeed+bounces-318-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C71E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 05:36:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YS0D76Thzz3bSY;
	Tue,  7 Jan 2025 16:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736228215;
	cv=none; b=QKhzldHv2/5gcSrABxP+JBBfypFpwpNnn1wVrulL0Dj9UJdV2oTnYWoX7p+UmYo3JuCgjGk5Mpo0fImosIKHDWoBdDJ+jSWxmMES8kB22abTxHpaqSYbPzx+D012c5JfDkIadKm6qjYBx7rZkFvTT7dHckz0NG2ufWAk8r5iU/2Ew4cQeIKugSj6zNzpef8gOPkqDCzpyazyTP0rIy+LOCWiEkxc1hhaMgozRcyBMM06UKcFoAnaW7gOlHpq7Q5ZaTF6QgtSPdMC53+SV3gXZV/ET1B6muzkQmf/Bp4A6lSnDWAsUuXoyPBDNgx6J6jwkcRVLDVRAhNck22jvVChgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736228215; c=relaxed/relaxed;
	bh=LS6g789aLB8ApLS1q1d05BR3y23KGQ689leRV5Vb9so=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JmyX592DlGFEYTeGowXPxZLRxzf9Z7MDBMjqC4PM4BAPF898d2HLqHRejElihfbeBz71QIFcdgY3ST46e5T5LfC2u//C4cV88whid6IVoLnJxue4agnpqhmua+mNeaDQgbJSi0IetzXjOMm75j9DFsAc7s/fw03juFMwa6CvdNykfa/HVlZ9sH9iARnEdoom6sYBUetfJYer9CpESsp7w0IazGZZTMYpv0p7Mobhsfi+sZYjfO1MJS1YgaUT19++Ktj4ZqwIBSgVqWI/iXv/t+aMBzbLtfFbMYCaGtR5BNzsX0f87MLV79oRwk8vm5mbXWNJ1NWb8TKGOxbbHBbOFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=PoNvvGRb; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=PoNvvGRb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YS0D70QNZz30j0
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Jan 2025 16:36:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736228214;
	bh=LS6g789aLB8ApLS1q1d05BR3y23KGQ689leRV5Vb9so=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PoNvvGRbsBte9//EfiRckwJTLJc5iTLakSR0TjCowl4xcFJx+B2MlUYLh8DgWVtA9
	 +nWw/DQDe7EtDtE37FLAiPSeI4fa0SATvGfh1Ps5BsWQAyWsOJJU+S/mVz3V9hI60x
	 TMmHI1HPeR9WKrjsvxg/82JHRUuDjhPeZG+HK/MF2CN/8NwPL4wqXsb9mkVTYcdcHl
	 kjzRDP1rwSXXWy7NFuXmRh/drKGVuefB27i8I8UwFr6GByaa9NNbqWQYe+jk0wFVdG
	 3lcu7WHBcxbgtzX5jnClTJRf6HRivENtNqB13pbkst5RcvHKTldRrOddKmrRIXUhFQ
	 2JpeLCpYBQBFw==
Received: from [10.200.97.88] (203-173-1-122.dyn.iinet.net.au [203.173.1.122])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C87FE706BE;
	Tue,  7 Jan 2025 13:36:47 +0800 (AWST)
Message-ID: <0b592466305793dfa788daced6368dc4c9e3852c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 4/4] ARM: dts: aspeed: system1: Use crps PSU driver
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Ninad Palsule <ninad@linux.ibm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 eajames@linux.ibm.com, jdelvare@suse.com, corbet@lwn.net, joel@jms.id.au, 
 Delphine_CC_Chiu@wiwynn.com, broonie@kernel.org,
 peteryin.openbmc@gmail.com,  noahwang.wang@outlook.com,
 naresh.solanki@9elements.com, lukas@wunner.de,  jbrunet@baylibre.com,
 patrick.rudolph@9elements.com, gregkh@linuxfoundation.org, 
 peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Date: Tue, 07 Jan 2025 16:06:46 +1030
In-Reply-To: <d3de9f99-1cc2-491e-8dac-1a5d243e17f0@roeck-us.net>
References: <20241217173537.192331-1-ninad@linux.ibm.com>
	 <20241217173537.192331-5-ninad@linux.ibm.com>
	 <d3de9f99-1cc2-491e-8dac-1a5d243e17f0@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Wed, 2024-12-18 at 07:16 -0800, Guenter Roeck wrote:
> On Tue, Dec 17, 2024 at 11:35:35AM -0600, Ninad Palsule wrote:
> > The system1 uses Intel common redundant (crps185) power supplies so
> > move
> > to correct new crps driver.
> >=20
> > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>=20
> This patch will need to be applied through an arm tree.

I'll take it through the BMC tree.

Thanks,

Andrew

