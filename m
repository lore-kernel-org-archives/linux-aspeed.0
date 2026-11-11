Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC561606A324
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KD+N4m3F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ09k5vVJz30Tm;
	Thu, 12 Nov 2026 10:30:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794439802;
	cv=none; b=TYR9Z9wSkfBs0FqcDMqEhKOemEPwA5LBHHYih5cS6jJTp/2Imix1+CYkLVfvTSGZYJnyPJ53cDVcVt58pjXyb6k4t37Z3FkeW40o4e3j84/MI07loiRUR4QucZtJTIEZQWaN1oCz0xbEEuf7zD4LB6fKxBxth7k/UIHLT/InYEtw5BVajE7O42RvdxHkTL5A0eV8fWd3Op+ZIIHkKy1OlnifjL06UgX1k3q89cs0GG6ld55mkGbGR/bjvEMcsX+NQ6Y0MTn2I4eDyT+9ccNM8Q5zbttejHIUDs0KTMyw2r1O2XH5gs/9StEjxqqUza/RFXgTtA1TUnJLy9yDuDgMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794439802; c=relaxed/relaxed;
	bh=4jTQv18d6f1WQDZPy8KbBDvAw2VyV9v3NRrsYhICvJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0xBH/GEwFUSOmBSV7WGFC+OeL8xbp4ZYffQAaGFb33PmESFEjJS3s5O5vIz98Q7NpXi/n4kW3R9I629Aks541WLcdYR0+ht2lt/qxONEBRVe15VFMTq+cFEJrQNNzPkeBlKu0PwKkWe3Rk5OtAYdQEKceBtb9wlPiFc2iNPWqiH8faYm2Eg4Lj67mQhcjpluhxAkM6zM444ZLoM7FwNFkwr8cEZY5yiMHgbf4KurGfVYPop9TjsUpt71nUwjepv4k+WIGtyuBVxg4FNR43y/cdMmeE6d1BjxDpKEXh8a0NR1MlCb9wzFmCHEso+U9XSRw18L+8WFgSap3L5hkIePg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KD+N4m3F; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KD+N4m3F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ09j2xnkz2yqs;
	Thu, 12 Nov 2026 10:30:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794439799;
	bh=4jTQv18d6f1WQDZPy8KbBDvAw2VyV9v3NRrsYhICvJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KD+N4m3FafpulELFLuXVw9qA2sr62kqjZns89QS9ygPOv1uZ3Vt23iID59FR9yobW
	 mXLcnCqeJXqjnuwkx3u5k5yfMVCSahFMzu7cjYe1WBBMdryWAlcIhe6EmViHIozTov
	 jFZ1X7gUWke2ocIFRWQtMBBZChLgvJhg8cqNOLz26uy3ticSXZk2LNWiyavGR2YNg0
	 jXKd4bklxKqKdmWlik5SxLDO5xidJ4pupeTmBrqs+fKBCJkPAo5Kjzb0XNbmkHKr6k
	 Vdb476ZIPgAULgRS/7Jwt1Bzj/sTUfZc3fJUV+LeO2fTr06UqmsMUh1FKQ8nS899if
	 H5eUI0c0Xz1jA==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9EE65704C1;
	Thu, 12 Nov 2026 07:29:57 +0800 (AWST)
Message-ID: <42bb0b817905637239c16b94a562254cd0e6a644.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, 	ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com,
 devicetree@vger.kernel.org, 	linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org
Date: Thu, 12 Nov 2026 09:59:56 +1030
In-Reply-To: <179438627442.2016371.12057101111349178921@nvidia.com>
References: 
	<91edc3ed1d65a6765530895c6574714bfd76b8d0.camel@codeconstruct.com.au>
	 <179438627442.2016371.12057101111349178921@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-11 at 17:32 +0800, Jacky Huang wrote:
> Hi Andrew,
>=20
> Thanks for taking the time to review this.
>=20
> > Can you please expand the description of the platform? Why was it
> > designed and built? What's its purpose?
>=20
> The NVIDIA MGX Vera C2 is a Vera CPU-based server platform. I will
> expand the description in v3 to clarify its purpose.

Thanks. Just to make sure we're on the same page, I feel stating that
'NVIDIA MGX Vera C2' is 'Vera-based' doesn't add any new information as
it's already in the name. Describing the purpose would give better
insight.

I'm after a helpful description in the commit message for the purpose
of summarising the content of the branch when I do a pull-request. 'Add
support for more platforms' doesn't really cut it there.

If the platform is described on the web by e.g. marketing material,
please include the link.


Andrew

