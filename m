Return-Path: <linux-aspeed+bounces-2994-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF1DD0E6ED
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Nov 2025 13:59:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dG47g40c3z2yFJ;
	Wed, 26 Nov 2025 00:59:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764079183;
	cv=none; b=KnfnFJK5AWfvRN4NXL8V0SbzKD2Meya8hYa5R9QLiFLk4/3B1bQ/GQQVFSkN/ln4USLzeef2wk1KTvHaTeHF4oDZvTB7I8G2G1RjbXT3MRPdc/WWQfETMNhn9zI9lAaTVt1RR6Vz0Cjjws7hjyE9JUYyA4pZ+TAZCS0Ws3cHocuLwr/sjNIsrw5iOVRNFNOsz5ovDddH+u4r4sqOdBtDqCWAl32hhbobLlgedht1P+4e68dssFlB2dfrb+IBqQiIV+5CdbTH3VJbq/rKlZ9U4nVHtMYfQCyVzcREN8Tz6O7wyTRLh3ykxQWsciIl+NDNfSXSaq2MdE7mxMr15iaNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764079183; c=relaxed/relaxed;
	bh=erz1zwGa7q1QFJ0zfxBY/HluYgM2d2IJi2gpOkUhWGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Rdirn6IJdsS3pBEWE71kfpdLsqaZ5U2SXwpk8HNjvCrF168VnaBwiaIf5th61f9smCTI7OhfkNalZIQPKyx19gle4gfjBh/crEiKyqKsePID8Dw3p4+uGkJKPGfZWOSbEd6hYXts5RIQ8QvzbPfEi4qfrR4tmIWeQYIEA/6muxvIWwiOhNl1k13Ke3L73mWDl7AVUZ4dHdpoSpR166WkQgoiYWHv4cJjiTg40w2rgGUnLXRkemtFFQufS8JortDLT4KQn6hH4uE6WjVnO04EHGRS0+CU1PIpaWZfqrXt5n+cmzdHtMhOI4MFKdXZHcJujh5UobfIN588CLN+Bka+vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BugdhAAe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BugdhAAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dG47f0HH4z2xPy
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 00:59:41 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-7ba55660769so4832023b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764079178; x=1764683978; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=erz1zwGa7q1QFJ0zfxBY/HluYgM2d2IJi2gpOkUhWGg=;
        b=BugdhAAeGyoJlkKDrxJxhikrZb82TW9GxIqufrrt3p+ViTb4Wv1o3JZYIFCwWDx8As
         J6T7bfxFIqCTrBg+ZwWpXr11jlK4DPQS9cXZlvIs1Vvp/nFufl+ON1gd800LgKxtEM8n
         Z3z+ktknm1T+BpooQu8rVkcP7eXbeXUa8NiE+lB8SOeMNMIcGPzjdyANyn7yxJjd8QhM
         zh/0t5xqpDCS2Vouxw8ujWFqh8qo4k6AAh4YaEAJlPtuBI2IPmWCKaNZ5xxDDU/qBwRw
         G21EShtICPKb7s46Q9nLzAfVRS1O6L+Ti1CTQ8hqPBKpQ6x2KWXgMUKeSV03iKYcg8Vr
         UWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764079178; x=1764683978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erz1zwGa7q1QFJ0zfxBY/HluYgM2d2IJi2gpOkUhWGg=;
        b=bnZAAoEs645aO1jS333ZA4c7f2+QpIP1sR1SlAvNpeS4P6Ufl7cVZS+XUeKmDfFHBP
         e6dwiAtN6RPHba6sZYpzzwf2n/8fjXRp0lGeLoFK+advit5BS8BJ+JNiu11qNzUVjB1W
         QtmeIIONC+De3Q8gRenNMlf1wZ3KEqUq1lF/iN0LhGvT1wM5QyYhYpMMRD9cr3xUowsq
         IkZQ4dx6/uUqHksVfdJwOO7rjC91vdpJfqauwxRp16EwfUbr3tiqeA6KLt9Pe6aa628V
         GNx/+41/1LbP2yWZ5uEEkMoG6hW2IfaqIg4qkEO7/+GmeJeXtXcGz/BDjhwlPpCZo3n+
         3lQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMXNQRKri176E+odi8RZhUVtq5iE94qOgG6QCFGIvCkS1tb3ZJExqX7JmtCCH/ekXdaSZS4KKxiwX6LI0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw5bgNudxP7vts+DDL5pmwjgKwLxlrXifcPKHDRS6Cp28zsROne
	vfN9KLoNiCjSDLmjwbI6e+32TDDzCNQGPQScZVgxqNQ43vHg775uGv3o
X-Gm-Gg: ASbGncvYOduNHW43G1YSJfmgf8q/vW32HbP3uzav4Q+MBO6jwMr6HtAtZKmFCz/+x5f
	dyplts7PbyluAr1k7IyMYcEMsCcDTx2w1BmMy3iFY7Hq5oy+o+2jIUcLyR+dLaNTaDuV3L8X/Xq
	u4SGE5Q65i1tQsly9poMHs2eZHYhWb/qYnqjt/9y5LIYrroWC2+1L8ZpNIpTDfeA0VrTse00o3S
	PyiCCuLFBjpcLM1CIXfJrCRUN9seAW9Yyy4fnCKSBjBIqdfsUx+CMXG5sZy/RoErNidcTtPJbQQ
	4un37CUgdyqT1EUF5Nac7p+dvhcgN0Ouu9+fd0AVgOH3OFsSgJtR5lbDyIbqXeBDInQ46NYeae0
	qEOtNoIRSNa4B2LHOlbaQ0lhmfcZzDgTy7OSquuwPxBYN49aTWV9gMs1WPQcGQ56W2TXkxD5Ny4
	gtw+NtmgRnrjhY8Nhhp0PfxigOqHM1aDAFveI/FTBMuhKhhq25UQyDXVTMtXmZ1lEZh/oAEy5Dv
	DU=
X-Google-Smtp-Source: AGHT+IFVBajfyb+jYLNhskTrqSPpLmpzWD4wi9ojL6pd3vnt1+ELM9ZLZ7EskwccDjqdCqnuHCwSjQ==
X-Received: by 2002:a05:6a00:2e9e:b0:7b2:1fb0:6da0 with SMTP id d2e1a72fcca58-7c58e602d9dmr18324022b3a.28.1764079178410;
        Tue, 25 Nov 2025 05:59:38 -0800 (PST)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm18216028b3a.50.2025.11.25.05.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:59:38 -0800 (PST)
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
Subject: [PATCH v1 0/2] Revise Meta Santabarbara devicetree
Date: Tue, 25 Nov 2025 21:59:29 +0800
Message-ID: <20251125135934.3138781-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
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

Summary:
Revise linux device tree entry related to Meta (Facebook) Santabarbara.
- Add IO expander node on the switch board  
- Add SGPIO line names to control ASIC module power  
- Add IPMB node for OCP debug card
Fred Chen (2):
  ARM: dts: aspeed: santabarbara: Add swb IO expander and gpio line
    names
  ARM: dts: aspeed: santabarbara: Enable ipmb device for OCP debug card

 .../aspeed-bmc-facebook-santabarbara.dts      | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

-- 
2.49.0


