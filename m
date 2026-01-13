Return-Path: <linux-aspeed+bounces-3302-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CC5D29DCD
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Jan 2026 05:46:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqysc75DNz2xqj;
	Tue, 13 Jan 2026 16:46:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768273151;
	cv=none; b=gqVao9e2is9o+jTrImEvlEP1MjGy5KQd1sSOU8tYYvTwNWOemOFSM3xWjbpPH/LB4UF7D4YmpejXm3eHEjLVRQgo66HetvqANR6LTjd3wt/pfFa12CJ25B5K7YVORhRytlIMiGnmn8BQKGS1r9vX2Mp2BnIUcbIvd4sRuJ22TMjz15hwVhOFc92PGaSF7J9ZKRWnMEatukRsCNdcrpUVDhdPXdx3o+88EImGy2P1bdwpkCH/W5pqS9ozbzgc3dbLFfuKnHHqw7jJ/CSx33SzWXrukMcj1S1JKbUKaYSWxHFkUAohb0lf8U6HN6JqSgXox6cx7QaMZjrpnxwx6Ak7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768273151; c=relaxed/relaxed;
	bh=rFfXODjCRVHA3oXyZnoybHJItYbj+O62t+8u9pd99Xw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mh8PehP5u8ZGhjl9dkfAAgoBeX4lx1IpToK/ib4qikRHgaJJbd7TSU99wlbpkimx1prbCdBhE2wve8RCE+W9F2PiDbRKzQlBT6+iBWuqujXA4jLhyQIJurqK1kxasgTs8oeRuA5uuJHFT3uxQ+ADfLxxsdC9DU3w6n+1dUtZYkmU0ga5n28Bgu3oTGjIMGB0m79uiojOHmFwKLkzQ13QlpSXxxIhJfbT/mMf3tXEQZ4u3vp5TYYeRaQtQvmLJL+j5G3jDj+3cXY/8cP7UFMahJWAit+9ndshcrIBXzAOv5VrLZXFSyfNv88Kh2ZnetJbUzoMF4w7oX43MrqjJCEUsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V68D87cd; dkim-atps=neutral; spf=pass (client-ip=209.85.210.179; helo=mail-pf1-f179.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V68D87cd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.179; helo=mail-pf1-f179.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqv8t3ms3z2xJF
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 13:59:09 +1100 (AEDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81345800791so3578362b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 18:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273087; x=1768877887; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFfXODjCRVHA3oXyZnoybHJItYbj+O62t+8u9pd99Xw=;
        b=V68D87cdmOmGbLg4XAe5Dqw66BzIRmkyG6BsjHkhY/K9GTqdRVClruQK4rrNs02jNf
         a5RO2p7/HRE3fgq1rf2Q66sXhmqMcdflZrtpDGuvhPZPDL4VtnBqPst/ejoDoT2Gd7/Z
         v58QWcEDS6COcgCZf/KqyAS34/jyJnjAcjnaqz+bj7HcxxZYXYu+Rjbgpo5C6l2lTShz
         2TkSAEqpQWChnM5CQp9aK6nVqVfLWly7KLnkW7Uy2KcoQh7Bszk/wubcpPXLulRG6R2x
         wOFbbYKda8FArWIMvMcds4CKHHLyRYAKGlwAxMA/yHCcQQmnGlAQUYxkj0EiIyY04yiM
         dJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273087; x=1768877887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFfXODjCRVHA3oXyZnoybHJItYbj+O62t+8u9pd99Xw=;
        b=kInWWyTdlex95jixF4GBX9g1YcLpfKBQ6bmscYvTK6kaK3ugaLPvXRU1X5TUnAG3fU
         hhCRhnnO2JtOX+SOWt0i47IBbRyS7X9b68mP5OTx4SNiZTFCfGXACDdtgxVLDZSbaXcT
         RAHotY2noJXkhGs1+IZ7phuNcjrdGZlzdroaVPCNUlXe2AgNkmw7TQlBvUISffSIF/g5
         eS0BQx1TL1VtSLNLGpJam47+wvSl7x/bn9GfLS/rtV1B+q34Ngi/Xexvk9nDQjKvfjFX
         H0sh2cNreM1MUmKbXbtBEsCRYSIaz3iwyVc4ikb4v2I9auA2k09LLvIVrsmNin1HE7eK
         VD6A==
X-Forwarded-Encrypted: i=1; AJvYcCXoqkVYSu5QJMOBmJtCbC4G6uj/NcXy6BQB7zlaAzt5hw06EqQDFnucUCfMi7ZOI+OGmqx9w4C5Jf9lgsM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx605atJ/lCvQJZNT9cCX582hGsUtnBgabjv91893IpgvNbLy6e
	19cRQmjue8j2jJ7EtLxfMK1uw/I3QNfDSSvG0xGT/HrcVgeZTvX4p5o7
X-Gm-Gg: AY/fxX4fvZ31O8ym8xcG/bkCiqeecpyljlCfXCODJYWB3jn87Vb0PqFCfGLEFhcUgwI
	J4mOeg81/dI2SSRtQ+lHQTRRwKVfbXKEj1aXiesz68CB2ReX6E8pst2F3QIycm+BXIQ0hQejvDn
	Ie6jerNbnIuAvpjZnOu2vahWTN8Uxkm8z95K6M0cWQ/q7U2RgVyE+J1StWY2vRopWyuLmkEpVUi
	H5iUboaFT11VetGAisLxXSzfrk2lIRD1Ye3t6pze+JfWBapxmAzxPFeu/odW5ZwGXj3WjcH81wq
	hZ6OrJ5AzVTM0aOF9yR6UFHU1vfLscKA8dZiKgRpk+iOTEz0fWe5IR5nsgkVto9GFw4vYIYt7qv
	ZoMBsqdYkvcIBODTHrne1SdJHRskyrcJJFsSZbSmyV2d3iyDzbeH+VYUN72ReahfDh0pz+dakoK
	zB1r+kuxujbpWQdDczFhZS4NEh9XACiR10e8QK8j2OLl4c2VUkRwE=
X-Google-Smtp-Source: AGHT+IFGjSWJ0/N/jssuSA4G7vWWabFAFD8WCwkp8/+SFuj7W2uo6HpZBUBUR8JLjzWJaFq/fn4bfQ==
X-Received: by 2002:a05:6a00:6511:b0:81f:3c34:fa7a with SMTP id d2e1a72fcca58-81f3c34fc14mr5522589b3a.39.1768273086884;
        Mon, 12 Jan 2026 18:58:06 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c530133csm18702724b3a.31.2026.01.12.18.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 18:58:06 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v3 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Tue, 13 Jan 2026 10:57:57 +0800
Message-Id: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIALW0ZWkC/4XNQQ6CMBCF4auQrq1pp9CKK+9hDCm0wCRQTIuNh
 nB3CytdGJf/S+abhQTr0QZyzhbibcSAk0shDhlpeu06S9GkJsCg4ABAo3Xzw2uo0OGMeqjMHGj
 JylqAUkbKgqTTu7ctPnf2ekvdY5gn/9q/RL6tf8DIKaO8ZZJL2aiTFpdu1Dgcm2kkGxjhE8l/I
 JCQlpei1oXJmfpC1nV9A5xs8TL9AAAA
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=4g+wGXOzU9O4o728wxdzupLqoaY0H+UaF3VynGflQsc=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpZbS7Nwp6cSSumZLmoON0Cq6yF7x8Kf26aO5sX
 7TAG9KFxv6JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaWW0uwAKCRClg0K3CVbE
 gUylB/42ekjg9KvH3E9Mz9qnzsc0txXIwLQK/t2U85LJDsO+zMrJXCUonA4apS0nQBHnIGBUGS3
 vZpHn5wrjMjRau6TfaRuDKcVvdZBKGYjzU6OKKW1mAWNGLAgbC8MnDyUaUFCiruIsPTPcYjyuoK
 dbdXv86abQbgosBL5rHdkOFfqwyz3iWpSjI31GlFbQc28+76UpLe5Zm4QcSJn1wJgtWbUUp3lZq
 1dIFTQP1glVTi3VqHrpKj1uDLC1QZUzumV2A1SblHgMBoROx9qxOO8ofcCEtQ1TgNZlUhnxrJ99
 GKFKECn8vOMN2sHZqoSlrh2LV820xgUFcyNlkk3SLfUPxfHu
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v3:
- Add annotation for marvel 88e6393x
- Modify the gpio-line-name
- Modify the node order alphabetically
- Modify dt-bindings document for rmc instead of bmc
- Move the gpio-line-names to original node
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com

Changes in v2:
- Remove unused mdio
- Link to v1: https://lore.kernel.org/r/20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: arm: aspeed: add Meta ventura2 board
      ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2874 ++++++++++++++++++++
 3 files changed, 2876 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


