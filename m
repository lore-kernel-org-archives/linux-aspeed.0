Return-Path: <linux-aspeed+bounces-4645-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8163EC5AC7A
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcnk5N6Kz3bxM;
	Fri, 07 Aug 2026 18:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091514;
	cv=none; b=KK8jkxHSsK8fEbjaHdppPKh0kjNANyALLImk4T9Z9BUupDz4M4LpNXp/+utvqx2cVMEZa6NpQR+D5fc1Y4u1p2XIqNf0vGcYFpJ+JH7By/XDVKR9QzA1k2y+rk9c2IPuagnuk2gXsZtGtcnsiI/lWf9GqI38WKVSnPSNoJ3cPY5Q6BYYGGeoJBqWqfByneaPjgflb4Znfi96Dwmx52OIScZRh3XaXKZJWLnRKQrL2uLDnUHVuCaWl/SSzQSVYARaQGYtX9BMDGkMyYpJvC5O847afvJ2dZwS80wGRWISyjwhKb3YRWhgZGwGKI9FwTXrgERBiDxIdF3ZDoRJ3rKZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091514; c=relaxed/relaxed;
	bh=kCBAfJcqbgF3AmCRrsKCNXyT2G3N/ne3bssrcVUdDDM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IThHuABxd/puXd5geRq3NTNFacNDM/I0mQ0ZWroo4WD6Ctv/WVLhPNaKI7x2ZsE4JnSooXBQrU6I+SH7Bdsl2ToCp4ZaSNqJLA8/R6qKFfdqrscz/aO6bDsauLdyJjkTLKybmHPVDB+F+03kigy4Dlv9lUgoxae6azIYR7BoozXkdLXYFqb5tVan59aY/DF7jvx4EhQPi0jLi/Oz8jfB+1b5C+5M0YSrmXjXOVg7TSl2HN3zESkxOcImKuAcBCZ3E4pOhaUevcr1izbzujhKFrbRhBp0p7cBpZqSh5hMSDsxCzHp9Y0gypICa3lYIcn2VaOAbCpLTaQtiuFEsFkDOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lhJYGGNb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lhJYGGNb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcnj5Kczz3bps
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:31:52 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-848761b5897so2217300b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091510; x=1786696310; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCBAfJcqbgF3AmCRrsKCNXyT2G3N/ne3bssrcVUdDDM=;
        b=lhJYGGNb80N9pZZahu+5dr/Ko9ifyBEsmJcOJvnZgvcyGGPnGVkZJJMqHb6vkCBHoW
         H+cT89lkrRNvQDlo5Y0lgZPeRA9YZYA7zCmFRi+L6UiCVNDQSQw1mFAEXhK9IX2UgTvZ
         j6tHC0qCIZpdfxPEIIbTj60MrWvvFbSira4naS7QkJkWpx0j3PJ4QGSx6Iz+ydw8eEMx
         kMgkX0QrlhRL6OaBfEyZ2CarsOtGzcRy/Ysl3DNYralTEx9d4uEJGVo1yiGwc8JgKpK+
         zawD6Rb1wTPL8vygFjTErsbrModLmscZi7jh97iBMbZBRduyV8B6srm5fSUyYFM/et5L
         Hf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091510; x=1786696310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kCBAfJcqbgF3AmCRrsKCNXyT2G3N/ne3bssrcVUdDDM=;
        b=BILSyoaIEqrThmqVnOrRxP1hzlrHDPQCJxlb6oipHxocZ9trBthaInxMJdq+5XQP1J
         S9Y2ifJHy/MNeZLQbo13IBf8EWQPC7XGkqBuyX/8lD/C65xUfsjlaCNgZEb7U03Ky9iT
         4zEO3Ayp+to3vPtiq6iTrbsc/RDlHg+R6C+3gEhL/bnjTiT9RJqX6ThJOX0vNmJ64ISW
         Pm6blKrE7W4VjXVVQ4MvXUL9A61RgPuA64ouZQ3tRVQ9zDFedB/vO2+lsOv0CgIbEgDJ
         Z8gut4crIykITxdCZUTR3yWxXUVUdirROAnZcC6MSklYMcmQTqY+Uh9MzRH1/qhA6Ycp
         ZhEA==
X-Forwarded-Encrypted: i=1; AHgh+RoWFq0D9HbtdfIS6ojuApAV2G417IAh+ALGIXrsXw08VjV91fR2TuHU8vfgW9y5yKgf3SHy9CJcWGd9NiA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzA0qCRVhA5RC5D/pwVrLZWXS3fsf+98WxkcNSMThZzTAo6Hlje
	xyT4nsxHjVUZqmQxD0ou75Qk5DWjfl5SyxY6rxHGHXZkPW8Rgil14EUP
X-Gm-Gg: AR+sD112V59+EuayXMWy5H5EL6H8YJR3nIzpLzSItYWQPEmFHeAJjcQeauAYfwlV3A1
	LKIQh2+jMW1bD4qqwDH0BzMyRSzcWnarr0o1syi74LoXOgSaZnbNp2lV6W62zQJ+rEQyeWlXM1Y
	/5qwUQN454nMAJ2dvm3que0CzraZMOv4Gcc5uhwNdK1TeYj95fIZfu/42Sm2Ixgt+KBrFQ8aviT
	OoXO8BYbQDjYAMRUgqtkop0xvQOM9RXIC0tfKO5HqolvnxnODsGFUMW6TlnFO5wsTBVL7Wb/t44
	6XLBcK25Wz6YC3Xln64WFxcmvBoGUixyvHyyzJfxSTKF9CMtDhZBjHPac2ONwfirTAWFE2gsl3e
	TvUawszaElWGJ/B2VHSXZXh48FmOn4BErWvotrJPUGAn0Zjwb8Mju0N8UXTKXxW1KSERvsurRuj
	k+emhSPPhpL/fuzfS3+/t4Yc/OEjC2o7iD+ApMYlrLwvewy3jrSkMiMMONLlQXzlAbW3bC2al2X
	hyApGzkt/ZOnp6A/lMIEyqyqHkR7lzn+RzXupeGruc71/eDxA==
X-Received: by 2002:a05:6a00:3d4c:b0:848:417a:d1a6 with SMTP id d2e1a72fcca58-84f2dff0031mr23770572b3a.15.1786091510336;
        Fri, 07 Aug 2026 01:31:50 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm627409b3a.43.2026.08.07.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:31:49 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] ARM: dts: aspeed: santabarbara: Add system monitoring GPIOs
Date: Fri,  7 Aug 2026 16:34:03 +0800
Message-ID: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
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
Content-Transfer-Encoding: 8bit

Update Santabarbara Device Tree to include several GPIO expanders for
NIC, Switch, and system monitoring.

v2 -> v3:
- Reword the system monitoring GPIOs commit message
- Disable power monitor nodes for ICs that now have multiple vendor sources
- Add GPIO line names for the JTAG CPU debug interface
- Add SGPIO line names for MCIO thermal trip monitoring and UFM read-complete
- Add a leak-cable-presence IO expander on the module boards
- Link to v2: https://lore.kernel.org/all/20260421130344.2751662-1-fredchen.openbmc@gmail.com/


v1 -> v2:
- Add system power fault alert and E1S GPIO expander interrupt
- Add switch board SKU IDs and power good monitoring
- Add NIC1-4 power good monitoring, reset control, and fault detection
- Update the commit message
- Link to v1: https://lore.kernel.org/all/20260129073749.3155383-1-fredchen.openbmc@gmail.com/

Fred Chen (5):
  ARM: dts: aspeed: santabarbara: Add system monitoring GPIOs
  ARM: dts: aspeed: santabarbara: Disable power monitor nodes
  ARM: dts: aspeed: santabarbara: Add JTAG GPIO line names
  ARM: dts: aspeed: santabarbara: Add SGPIO line names
  ARM: dts: aspeed: santabarbara: Add leak cable present IO expander

 .../aspeed-bmc-facebook-santabarbara.dts      | 200 +++++++++++++++++-
 1 file changed, 192 insertions(+), 8 deletions(-)

-- 
2.52.0


