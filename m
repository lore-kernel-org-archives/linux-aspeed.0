Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED57606A320
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=f7zVJPYL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNDmH05bgz2xdb;
	Mon, 09 Nov 2026 13:50:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794192622;
	cv=none; b=kvUV8UuJxNfaFPkxFRHaYw1p6FT5PXTh9xEe5HrxA8LRVwXUnElx4k1ohFQ39StJWgLLxAlyG7hRgDbrtJzyI3RWcQgh/VIwFcyEG2+umsNMuLeftOA+5Xui8FXqdKQRFSFLYFqy7MgTfiFe8h2JzgHRZ72ABTxZlcEquXzC0OKW+PGq5UGc5y8I5IWhnwZBprE9TIWemIgoidgv0wK2YxHuBk7usTqIbehT37xN7AcYRDzegqvDTL7QecAr8kgUG03t/rORkw5eA1bC0aKlBA35wg8m9mAQSG0HN7kPFDzvlWYfWisIaW0eZgeWWlyvqObUTrve1ZtqB7r/0ul9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794192622; c=relaxed/relaxed;
	bh=TgSvuOCz1yzqmQTBxIlw5PsX+cc1UxOx06GfU8k+6sQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ktYN43kPkSzo9FfRCLcr33XBOoErS9DdzTqBuJLZyPh9LcOy8t0y0RkbZfC6rRAe6a9RGvZBvB/z0Klwi4iKV+0z4eDbKaS4gokYC0YJ7e2/A0OON6+6mkTJxWMwMVbw8Z3g4mZgwA7dw+FeD+aO3Ig8WmfTLaLqDwYvVemujeebvZmFWz5j37HZJrMjn4MYoNS3dahSL6ZCcbIbFv2RGrvM/Z11UT9oMMSeaai92hUmL29iyxNkmHABzUgyDIBfULWYM4zo/RD2SWDA1d9PrubIj2otaxHoWlH9v1lbc5w9LgzMtqUF+JWPm/e9EX2fOObqeTYj0xMVtnskgvHmvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=f7zVJPYL; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=f7zVJPYL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNDmG1ZMhz2xSS;
	Mon, 09 Nov 2026 13:50:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794192621;
	bh=TgSvuOCz1yzqmQTBxIlw5PsX+cc1UxOx06GfU8k+6sQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f7zVJPYL6RCaoVmAll7Ub1ogTo3eKSo91d9qzir4wCFe8e4Ye1g/9UpaKwACHuoYl
	 faLkyRQsHCbqSMTu9v6M+WZXBt2j+Pq4jZdmAWjWlnwIZNArKa+3T6XKgAZp8GZIZ5
	 zgNuJsAglH3MH2k9jUtcXucof3VTa3H5bYDLBstZehQfZaDz9y5JMNKbXLMDmkR+NZ
	 MrZ6xPEHk3gCtIc/PCNG4RLTFcmPM943y7eRLeFTl8Xzwg8sBcCEbQNsPi6frLzOhE
	 xXcQx7JAWLUFTTy6h4aDXZcN2JXpoAQWtvj0dNTrgTchVZrSTxd9QzSTbDA+JP5o2A
	 r7UvTkQwu8prw==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1DE1064952;
	Mon,  9 Nov 2026 10:50:21 +0800 (AWST)
Message-ID: <14d76dd026f6d1077a6ac388a6a2d6136654c58e.camel@codeconstruct.com.au>
Subject: Re: [PATCH] pinctrl: aspeed: Use managed pinctrl registration
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>, 
	linusw@kernel.org
Cc: joel@jms.id.au, ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 13:20:20 +1030
In-Reply-To: <20261107012236.28069-1-prasanth.padarthi10@gmail.com>
References: <20261107012236.28069-1-prasanth.padarthi10@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 2026-11-07 at 06:52 +0530, Prasanth Kumar Padarthi wrote:
> The shared Aspeed probe helper registers its controller with
> pinctrl_register(), but does not unregister it on device unbind.
> The registration can therefore outlive device-managed data.
>=20
> Use devm_pinctrl_register() to ensure the controller is unregistered
> during device teardown.
>=20
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

