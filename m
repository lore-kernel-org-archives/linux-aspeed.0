Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3EF606A326
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Nov 2026 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bc5NfN5/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHqqT376Sz30VX;
	Mon, 02 Nov 2026 09:52:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793529975;
	cv=none; b=Czhw2DW6qOQ2n9CvF8O7LGEeill21qcn4PR4spJR6YCgH+i6aHjTpBpgyudKKCnBn6QBdCLcnzGEi2ZBnla7Cjs2/DMX53kHOKE9y6vHZqfj+Z/S09+ONT7yd3hrPNzOx12wb4AaidRcyOTM3Kctqgj4v2JucKveK4T41BTJ7vlK/3Snvefnm+P0vxIfQsnq+W8DqWPY1GrKJo7KodIUScj7/3suZAo2DsqouUgJaV8mbW5FrzPOeSHXQPCuqJp0Yhd5FEf2/7Zspfc95rc77BWISRY0mmcaHLBd7j6w2QoNUQFZLmL18WW/2uIdrv0ctW4VShbCLhgw1BrF9JEE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793529975; c=relaxed/relaxed;
	bh=dGR9kl6uTtgDJSJ4dH0fCa7ftWGcF8J5cSIZIw5rbBA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OYOSD5JIH2oAuS78jVRiu3GgcvQf3ctZ8h2c651uslXJRQKpPsCN6+QTrVu07s1jFWhdmtyySi8AD3vpvZCmoWNHZOXJtgkD1skMjIqQ1FmBy57nPeCy/MLEDcS5XpqghS9ZQ3C/yewPV/JFDuw36lnXLnWbQTK+7HKIPRg6TxMBVG+dCHriZIlwlwLKiE9ynL2C8XqYLmk/PUhZ0Duist+UH+9xF2+4LgMqFm5kaScHo5VUaR/JqvTgPfxYGV1E42bj0nfAmgK5UosHUKa0YWpNiovsvWR/Hpb/9JH6tgfCtqt2pALQar2yCKoMKjzRU6DffhaWU6fehEY+7/Tu4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bc5NfN5/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bc5NfN5/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHWj158Dfz2y2h
	for <linux-aspeed@lists.ozlabs.org>; Sun, 01 Nov 2026 21:46:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C52E7600E2;
	Sun,  1 Nov 2026 10:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5C51F000C1;
	Sun,  1 Nov 2026 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793529970;
	bh=dGR9kl6uTtgDJSJ4dH0fCa7ftWGcF8J5cSIZIw5rbBA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Bc5NfN5/LMPfNnPeH99MX6m4M2u5CrxRnQOG/BPkrvht/YNmLJwSIrTBGmoQxjeLW
	 T2Bg2buuYUycr0aVCtO/G/R2MJllHhAPat8oW/r1LdDyglvl2+Z2qDd0CKsWsPqXnn
	 j/sGVuY4gR0i2OuWmFHB/qu8qO1BzBXWkcvsCgfinMF8BR5+CsTYkRkwP/RUP8iK7L
	 B1OhEfAUIW7V5JaujC5Ylnb1W4JzBYfeqG8HPISXqmUneNsDDsmr740/E3atYdERwo
	 txryab4YqUcz5YKcElm9LGuN6ub5NCQMenoBLyOta7rhnYmLuPSSowmvHdOUSP8jhB
	 wN4e+sEzuMavg==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 0/3] Add ASPEED PCIe PHY support
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
References: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
Date: Sun, 01 Nov 2026 16:16:04 +0530
Message-Id: <179352996432.2955.15360734272963479589.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=699; i=mani@kernel.org;
 h=from:subject:message-id; bh=0ZANUh9mwDKQrUQv7MpH+M4ZYnBxlA+EOdANf6PQOj0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5xhuBnwVQvqgNHtWmOkbL0QfJ00VCESNLH3kq
 AAEIBKEXgOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaucYbgAKCRBVnxHm/pHO
 9bdlCACpAfx1ovYivAViX6ocpuk9V3nGVQQRN4wHXNNOOh/d38VrknBLYT62wsga7ryzjp2/Zv0
 1ycwqaSEHLEKjDlrOEv7qk4yQfA138LlOE+oIXYKFEc7vhZTfBgBRoZ7oQ4rws3YlD1jy+N1+J4
 WdxTxkfAyTF2wo9OgzdidKUyKTKOy8hCieWaxPdlyvCpxsjN+ZEPFs67UREsDvNGOiChBMJBe4p
 YWyNIWolqgwTP39FsjxNJyzsK0t+TlG/rGpqUZ2azF3phE3VQtXFO+TNnIuT2Mn2RB9jSDNzf4p
 KEzf1u1uq/DLyo7kv91RfgR5b23/clTvn/sQIvfvnGJzFplV
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 19:59 +0800, Jacky Chou wrote:
> This patch series adds support for the ASPEED PCIe PHY, including the
> device tree bindings and the PCIe PHY driver.
> 
> Summary of changes:
> - Add device tree binding documents for ASPEED PCIe PHY
> - Implement ASPEED PCIe PHY driver, including reference clock handling
>   and an AST2700 host bridge reset sequence
> - Update MAINTAINERS for the new bindings and driver
> 
> This series has been tested on AST2600/AST2700 platforms and enables PCIe
> device enumeration and operation.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani



