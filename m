Return-Path: <linux-aspeed+bounces-1888-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7107C87FCB
	for <linux-aspeed@archiver.kernel.org>; Sat,  2 Aug 2025 03:15:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bv7Hk2mJlz30T9;
	Sat,  2 Aug 2025 13:15:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754036598;
	cv=none; b=dxMnpg8g9RZrtbgkwWvZhwymH779WY4GC+aq2Cr935biG05Pzh6E8lZcNpSRQKNV6TAImcoKFfVal3kdJicaxVjl2S9uwDKjbzwm0dIwRCnonZQcNZrCGZkxfUg9yJz24UlDw9iFPM93nN6IqieMhv+uuoeOG5MqXKE1D1UEDZZ34N6l3xW782rHUKYMMYjOd9fckudFpfLsKc4YMh6rpiSWOswh9jJl6KcjWMpho9SewaP7Bjg67FToN366MyCOr4EY/2sDzkXWpIDv5/Z0k96t34ClpS7WGwlPbNslJkeSp0pg1eYOYldEkGtlc6FdXMTDb2Yf4pR/Bl2twB8uXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754036598; c=relaxed/relaxed;
	bh=9XTlkPv0IBw1LQNFKJofErU6zJZ+bp+//Zwh3h0I84U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X0HuyCCAmztxoXiDR9shW3xm9zTtjUP72U5tgnsUT6jrkh4ITcV61bObPc1rvsUn7+SPch+BxSSne/QmF6yl/0HgZQJZjyp3b/iM4WIhqELJc7Q8o9V9IWlhTSuXbjbmE2nyuNkA/RaGabZrNYeqVSCPQyKBAaS6StumQGlfftf8VvQwRlOhxsKW/U4f7IMcLoczWUirLi8mLIR9+8kOO50DcQU5zQUKy7zYN/2qdTJ1dkrUfk+AGajXc8HfHOYBxWV1grsFzudE4fEkAml5meG3Sol98/1J+A3C+SP2cEkZJs3eM6PmpIiFEElYFXvPW/I1TSwzAd5DjKSWTslnaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FOm22BfY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FOm22BfY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btf902CQMz30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri,  1 Aug 2025 18:23:15 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-31eb744f568so1094111a91.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 01 Aug 2025 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754036593; x=1754641393; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XTlkPv0IBw1LQNFKJofErU6zJZ+bp+//Zwh3h0I84U=;
        b=FOm22BfYuEIajLvV92zxvBrHoRhGuljwGcIuWlaQvJdd2azkEML2zN+UqwdnvFZKVB
         iOCi7c218FjKPZuqWSExNk7zkaNG7PP3wFL6J/ONy/2siXEYCQdAQ9xJZgI5k7IMSEIj
         7SACnFmuppH9jmwybls2sg2dTZsntBkcXvhKLJG3nkdPsYcx/0vn28VQkDE9cO+kaEQ1
         wOsxazx90kU+VBHLgk78xIHQnuxsNzr1Oc9AUDb1C69dK3ugAkZ9E21o9Pju0XA4iL9K
         UeClFGRnsnp90VInQ7vA8AxrHg0pDS70D6tNz+Va6gCZ7rzbR7kKLymd5ILtcChmm11Z
         qSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036593; x=1754641393;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XTlkPv0IBw1LQNFKJofErU6zJZ+bp+//Zwh3h0I84U=;
        b=uBKes5TodD4Xx+8Ne/jYpefcw8LYjQ+TtyaR8IS16cgX0dV4fI9SAX67oqUjfmbw4S
         WMq4RT8Eg9v+EwafDzY6R6m0iBNMFPMee2TqN14M+Y4So0xV0ULZ7Mcq765BJZ4E2d9C
         Ds7gdQjN4/uvUhcFQVKgehUBVsZm2xU2ldwaHtlarIaOfEMiinW5QVmoXcepfR7Pr4iX
         d0Gt2zN9MXQaItas47ZCB8iVNV63TLw3YL/LOqQjGYj5jneDaR8s2NFC5RuydB16TKIh
         15yMZlBpuf7oRKf9a4ubvqJIStGRLL3TIbSKPfAHPm4q+WnpoVsuTohuM7S8QCpahZWa
         haEg==
X-Forwarded-Encrypted: i=1; AJvYcCXYOVNerT1CvH1YYxf4dVuunA7tyDFTgKh3CmBCZhzv+g0IpSyMp1eJpzMqlxUJuxHHli2pe4mQQLF61Nk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxubaysyIxv+F4YFSodeCLve5fCgR5z0u/qwM/ES7fvp405LoN1
	KOh2wqF1HMQCIz1eoJhblS/qTNl2FsPedHEbnNSfGodeoVexQyicVCbzfVUuNw==
X-Gm-Gg: ASbGnctc9AAFJ+7CIUVsz+wm+8W3i4Aw94k4/HVQxxqoHK4EcXHaotkU8yKvyaYlOA/
	nO+V3jcjk88sE5tEgXYdZD7uEQIrqkLrClBcSnxybzBNQh/rybESkA5aPKpp1OhpyZw2rJqt/EH
	6QeTma22o3BgF7rtqWJ4kGfB5fq03N0lm2WQmwEQlIgnhBfXomuhIV8RQIGc/PVhkICu9k1BI+c
	pNfdRlyw7yHFjvjTNp7bMKrkOb7y6Zubx35yfFi3ziqZKUUsr6uLSqMwb9r6aej7R+JSG5Ui54G
	/mryKnrTFqEatdpicBVbt5NGkwJiUYe+Ag/ndTbq0oQu8Gqt3HkZOgvx8hBpcKV9AQJ57aeNMss
	yLK65Tpshya2AQmIOVkjCztfAJYu7NtPTvGqBHpiX6pOiojUwifZlpji4ZhOHMUb9nIAXIaxBIG
	C1Lg==
X-Google-Smtp-Source: AGHT+IGvj0g2SL000bEpFWCRgDs2CE3+7rERXhrbik2vKVQje+4iGkCwmUe9S42Dfhh7fy3ca7XvNQ==
X-Received: by 2002:a17:90b:1c06:b0:31e:3f7f:d4b1 with SMTP id 98e67ed59e1d1-320fbd13993mr2917452a91.24.1754036592766;
        Fri, 01 Aug 2025 01:23:12 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3209a850417sm3992725a91.35.2025.08.01.01.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:23:12 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v10 0/3] ARM: dts: Add support for Meta Clemente BMC
Date: Fri, 01 Aug 2025 16:22:47 +0800
Message-Id: <20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFd5jGgC/5XSzWrDMAwH8FcpOc/Dn3K8095j7GDL0mpYkpJko
 aP03ef2ssAySI8S5vcXli7NRGOhqXk5XJqRljKVoa+Fkk+HBo+x/yBRcm00WmonQbUi5iymr9N
 pGGfBwyg6mqPAT+qon0mkDkWwKloICZ02TXVOI3E530Pe3mt9LNM8jN/3zEXduo/oixJSkMMIE
 IisT69cSn17xqHvn3HomlvGoleuVntcXV1ARyxdUDbgtmvWrtnjmuqi1oYZ2QLytmvXrt/j2pt
 LnlkbCxLttusedl11pWkpAytM4Z954df1ctfeoLqeDTmfsjQGtl2/chXscX11s0vJWxfQxbjtt
 mt31z+01dXMEDkZSJK23bBy991DqG7yQD6TzYDtX/d6vf4AdUIfe5kDAAA=
X-Change-ID: 20250618-add-support-for-meta-clemente-bmc-941a469bc523
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754036588; l=3087;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=oFW8Pcf+/M0flUeJ4t5z0g/SaacnwFP05q4Nt+4Z9wg=;
 b=aEkmJbS4z4oVHMRyPJVF+2OC67JWDL1S9Gy1HYPiBX98lLoJ4Tit/AnCyZMx10XwXEcHdsqdy
 kAurb9DK/J1BoDXviwLgykl1ayq8RLQQzkQVo2kyyjk5eYPsBgFQC1W
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the
ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v10:
- Reordered NCSI pinctrl patch before board DTS.
- Dropped MAX1363 ADC nodes from the devicetree.
- Link to v9: https://lore.kernel.org/r/20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com

Changes in v9:
- Fix comment alignment for // PDB TEMP SENSOR.
- Drop non-standard aspeed,enable-byte property from i2c11 node.
- Move NCSI3 and NCSI4 pinctrl nodes into a separate patch as requested.
- Link to v8: https://lore.kernel.org/r/20250717-add-support-for-meta-clemente-bmc-v8-0-2ff6afb36b0e@fii-foxconn.com

Changes in v8:
- Relocate IOBx_NICx_TEMP TMP421 sensors
- Enable byte mode for i2c11
- Link to v7: https://lore.kernel.org/r/20250716-add-support-for-meta-clemente-bmc-v7-0-d5bb7459c5aa@fii-foxconn.com

Changes in v7:
- Relocate CBC FRU EEPROMs from i2c13 to i2c12.
- Link to v6: https://lore.kernel.org/r/20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com

Changes in v6:
- Correct Author email to match Signed-off-by email address.
- Link to v5: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com

Changes in v5:
- Remove accidentally pasted texts.
- Link to v4: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com

Changes in v4:
- Move properties of nodes defined in the same file from label ref back to where they belong.
- Move pinctrl default configs for ncsi3 and ncsi4 to aspeed-g6-pinctrl.dtsi.
- Add properties to i2c10 and i2c15 to enable MCTP.
- Link to v3: https://lore.kernel.org/r/20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com

Changes in v3:
- Modify leakage sensor to reflect current design.
- Link to v2: https://lore.kernel.org/r/20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com

Changes in v2:
- Fix patch 1/2 subject line to match dt-bindings convention.
- Reorder device tree nodes in patch 2/2 to follow upstream DTS style.
- Link to v1: https://lore.kernel.org/r/20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com

---
Leo Wang (3):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: clemente: add NCSI3 and NCSI4 pinctrl nodes
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1250 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   10 +
 4 files changed, 1262 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


