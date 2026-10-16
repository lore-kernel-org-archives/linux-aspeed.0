Return-Path: <linux-aspeed+bounces-5214-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC32CCCA464
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 08:46:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5dpD6LrPz2yVB;
	Fri, 16 Oct 2026 19:46:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792140388;
	cv=none; b=kams1MwBCITkYfALQGJYKGT1ZVhXmFuUr2xgKAy4JWaMO3sg3kyRtmMi41il+Uk1LYL2+ZGRdOEJCy3opywCPbS0dNCg92au4iEn2D1QuM4PkosIv3mPgxqMooDnFRNm/6uhuF5XqJe/AzcuVZH0Gryr3HZu9L8s19NLV82cN5zv4r9DOvJsQ0LH4GExegCj08sJo+ttJBf3NPtt02X+QXNgjUXWOBzCFXXZEU+D5igeVZeBmb5ZeihtlTgjIt+bpA1tvCctROtZ7MxLT2yevB9mfGwzI65BDmg4bluepP3BVWVymTXhTBJqt81+35jj6bihZtQKez/JO8oRlMpLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792140388; c=relaxed/relaxed;
	bh=eP7FY3OQgnStG7pJcM3HLJIH3BqNv24XrFsKRwPXnqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D1BWb+oGALogG7+DswMC5GGL5WglPj99NW/qOvUFWxks3O0uRnobNJyYquVNeiYmprIRAbK+mKdo20NvsUOTHYjqaw1iFiRU6tvxYdZlBtc6lNJmkk5jO2AJdH5UfxRAMGblNLboWQURyf6GnKz36WUPFaAWFJsX1281NcG5xPgT/I0tzzdhdkqgN4Y5jLx7E2jLz06KlTDB18dVUaXczgz5n+IVkSyA2khpB5T8z4808h0LQPwF9mclsj6l3cNaO3lr+aLYCxWRDMu/fMF6LK5UcaN2gbFRYltn5alZWODCGTfCc0JsnKgczWTdmEoI5wRtXUeRkSSTPatGAh/0IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JdA4i2J8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JdA4i2J8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5dpC1xzCz2y2B
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Oct 2026 19:46:26 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-89e018e466eso1114387b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Oct 2026 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140383; x=1792745183; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eP7FY3OQgnStG7pJcM3HLJIH3BqNv24XrFsKRwPXnqI=;
        b=JdA4i2J85dQzrXO87upfv+yaRev21Z5YBONQzwAktrFxReLRGN8vDmjeoTwRaVUeIh
         0YIQ9U7lg3QVzJu6Vifw2l6bvuSyZRHBKt1GcGZPsD8ceHcD5E0iDDfiuivef4TglsM7
         vwwC4tmJ+4YoLMQGV5JABqhLUjuqL4FppI6pAig6drHoeaN9z9gzUvG1HYvjqTF2AqYV
         nF0C43C+dQ8PzHP5w6UUkxUuuN9hJVARYILMojmVgU1rq9FTPUSaDPa1NLgk6qV44qE4
         Wh3lFs3+EQ8f9E4Pu6VJKnCB2fn0nF1cfDmA6+EddgKUWQpXPD1FDZE4/27AXF2YiXnw
         7XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140383; x=1792745183;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eP7FY3OQgnStG7pJcM3HLJIH3BqNv24XrFsKRwPXnqI=;
        b=ceq69yALNW26ek5C1gXN3l52pu9Cn4WL01gayTr7w0KMbXGwg1YGjjVF0onASSmJZO
         ccjEqxddTeTT/cVRwbwVLkNpKeJNLyn+qZGzjp81PDyEN80CUGYGOQkqELh3OdxSv1JG
         rHDoxJu//ScuXSBOZExrRSbx1ilAnB0TjDM2F/6rsXJaQEkd7pIherIkrM8ia0m+0JhH
         tKluIs7kE/N5oq5NlhqWypSQx8W6Avz8zHBS6tH3c2plD8ZEqP+nhS+5jTynWnxoGB9m
         Ohi7pBYunWxcGjHnNbGp8Qnh+k5UJk5xHCqpo1tiZwKrT09WV4IFPA2FnpW+MQO6q/dC
         rYgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfL4xZwAziY8GNTAHAUpj5+VYfMrvEvOrieN5sNUG4gTqQ5qhgA681kd7yM0Pn0WdFdlE4W2r2FHVhMno=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLqgE4v0a5ex5Zx+3FVqax1wDXrllUekGdJ1aL5NVeFvKVN5hrQ
	ykG0O1OEN+6f2O9pdPujJ/UQ+NL1jbDR2izR7IAt+N8LzccykxIQvXW7
X-Gm-Gg: AYBFou3AGHryovI/5uNIRoR9NWtdedZWtqItMlhAF2xECKr4iHpe5RbUd5uloXictei
	vMf9eDUCb+Ix+1/iUD5KUByK0tUoRwhXiQpRfpf/SuS4LJTdVzw9m5vFFJsjfUnaOAwVOHIijb2
	/nI9fGJi/GRN+9I5A+bWHR6YCQmwIOnyf/XNv5ssraWJ/2/W1B8XIH40U4t19u+b3eQixOn1Ykp
	st9NVON9yW51ejqQxc4Vz8QnkAqM5jF8FKoFhZcTnqHWxBdqFbZe1QA/rMuku3TT4QEo7p/tqD7
	oRVPwEdrWzANZD6T2aQP/yDb4S7qwAlaP4hlAx3l1q5iFV2R8MONb5FZ3y6LycQGLah3rW5yNBj
	0czn4k8sZ94ULsXZPKQ5FP2rQExlvoD4mWNhuEOucp5o/enSjSyr8SLDJkkUEKLoLiYHtpHMubP
	du7LKoQtcmj6E3Fq/JP/6uOUzQNxIWTaTKjq0VM+wukucNKR/NrSrQx2TVmnQlOUgoIbYhOxISi
	wj80IIiQPTyaXXen+FlMPQia5eBQqfvaQphk7oeQhNvbBYp
X-Received: by 2002:a05:6a00:178f:b0:886:18b2:361c with SMTP id d2e1a72fcca58-897c3ef946cmr17880250b3a.7.1792140383169;
        Fri, 16 Oct 2026 01:46:23 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947b0esm756620b3a.39.2026.10.16.01.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:46:22 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v10 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Fri, 16 Oct 2026 16:50:28 +0800
Message-Id: <20261016-ventura2_initial_dts-v10-0-a546659a084b@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAFTl0WoC/4XQ3WrDMAwF4Fcpvl6GLNuy3au9xxjFv62hTUeSh
 Y3Sd59bGA0pZpfngD4JXdiYhpJGtt1c2JDmMpZzXwOHlw0LB9fvU1diLRgCKo6I3Zz66WtwuCt
 9mYo77uI0dhasF6h1JFKsjn4OKZfvu/v+UfOhjNN5+Lmvmfmt/QeceQcdz0CcKGjjxNv+5MrxN
 ZxP7AbOuERkA8GKZG6FdypK0E+I+EMIOBcNRFQEo8/RkVNe6jUiH4hsXiIrYoA8QHJScLlG1AM
 hMA1EVUTolJQPWRlPa4QWCIcGQndERZNs1MnnNaKXCG8guiKOeDQW0Af1hJglohqIqUgwNlsMB
 uTzY+0D0agbiK2IAhkgBTIg7BK5Xq+/B4rCleECAAA=
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6891;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=Dw70fL2b0plUD/9OzGbqtTAJXKQCheRPU6+zb6qN4o4=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq0eVZpleBCZqqfNsYKGcsYjmdftXDSEKwmFEz/
 Fk7HceNwaGJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCatHlWQAKCRClg0K3CVbE
 gZmbCADETLjO/mJloOC5b2aXbOyfCVndZI+m6BIevSwUcj90wTGsuiJwyVFTkmwFuzK6d/Jqnm0
 7rl4PZZ6NYSnW84hkE6fCnYI1vRQqZbUTn7eNCdqoMneyMYztF6LlAUnMRfa9oO5t3eyNYs/Cni
 pfq/fwmOLt6/Q9y9+ZFUH0F6I2nM8KMw+xN4krxRpLEfFtbQvWcZT9AzeCiI+UKVv9+ibA09SfS
 jE30Cwlj7GFRpw5hqVi7xQbp9LJjblBjmehWjXJCBzGgFiZAEL0YDMOoMcsDJtormME6XE+gdJy
 +qfWkotAWp2NKPuOxZOKOrwARqrIe/OUFwgL3p6RrAmvrffg
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
This series adds the device tree for the Meta (Facebook) Ventura2 Rack
Management Controller (RMC), which uses an AST2600 BMC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v10:
- Addressed review comments from Tan Siewert:
  - Restored the standard kernel comment style (' * '), which v9 had
    changed by applying dt-check-style strict output too mechanically.
  - Kept #address-cells and #size-cells adjacent.
  - Added openbmc-flash-layout-128-alt.dtsi to the alt-bmc flash.
  - Added a comment explaining that &kcs3, &lpc_ctrl and &peci0 serve
    the optional COM Express module.
  - Renamed "Sequence_TransFR_Alert" to "SEQUENCE_TRANSFR_ALERT".
  - Added the Assisted-by trailer to patch 2/2.
- The v5 changelog wrongly said &peci0 was removed; it is kept for the
  COM Express module.
- Hardware alignment:
  - Dropped static TMP75 nodes (i2c5 0x4f, i2c10 0x4c/0x4d/0x4e); a
    second-source part is used on some boards, so they are probed from
    userspace.
  - Dropped the INA230 at i2c10 0x4f, missed in v5.
  - Declared mctp-controller only on i2c4 mux channel 6, where the MCTP
    endpoint is.
  - Added FM_E810_MUX_SEL_R and FM_E810_MUX_EN_R_N line names.
- Dropped redundant status = "okay" from I2C mux channel nodes.
- Moved device_type before reg in the memory node.
- dt-check-style (v7.3-rc1 and later): relaxed mode is clean. The
  mixed-indent-chars warnings seen in v8 were false positives on
  '\t * ' comments, fixed upstream by commit 32541ce0ae ("dtc:
  dt-check-style: Allow space-aligning indentation in DTS"). Strict mode
  reports 10 [property-order] warnings, all from keeping #address-cells
  and #size-cells adjacent, as requested in the v9 review.
- Updated comments that still referred to labels removed in v9.
- Link to v9: https://lore.kernel.org/r/20260727-ventura2_initial_dts-v9-0-504c0ec68039@gmail.com

Changes in v9:
- Rebased onto the `aspeed/arm/dt` branch of `bmc/linux.git` to resolve merge conflicts.
- Resolved all formatting issues flagged by `dt-check-style --mode strict`, including:
  - Fixed 'mixed-indent-chars' and 'continuation-alignment' issues.
  - Sorted properties and nodes into canonical order.
  - Removed unused labels. 
- Resolved DT schema binding warnings reported by `make CHECK_DTBS=y`:
  - Removed invalid `channel@X` subnodes from the `maxim,max31790` fan controller.
  - Dropped the deprecated `aspeed,hw-timeout-ms` property from the I2C bus.
  - Removed the incomplete `ti,ads1015` ADC and generic `pmbus` power monitor nodes to comply with upstream schemas.
- Corrected the compatible string for the 40-bit I/O expanders from `nxp,pca9698` to `nxp,pca9505`.
- Link to v8: https://lore.kernel.org/r/20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com

Changes in v8:
- Addressed review comments from Andrew Lunn:
  * Added a detailed comment to the Marvell 88E6393X EEPROM node to clarify its hardware I2C multiplexer isolation and out-of-band firmware update mechanism, explaining why there is no concurrent access or multi-master scenario.
- Link to v7: https://lore.kernel.org/r/20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com

Changes in v7:
- Updated the commit message to include a detailed description of the Ventura2 platform's purpose and its key hardware features.
- Fix comments from Andrew Jeffery:
  * Ensured consistent blank lines to separate child nodes from parent properties and from each other throughout the DTS.
  * Sorted fan nodes in ascending order.
  * Replaced '//' comments with '/* */' block comments.
- Fix feedback from Sashiko AI:
  * Added 'idle-state = <6>;' to the PCA9548 mux on i2c4.
- Link to v6: https://lore.kernel.org/r/20260610-ventura2_initial_dts-v6-0-375d8e9d7ebf@gmail.com

Changes in v6:
- Addressed automated feedback from Sashiko bot:
  * Clarified comments that io_expander0 and io_expander8 physically share the same interrupt line (Wired-OR) by hardware design.
  * Removed leading zeros from unit addresses in DAC nodes (dac@c, dac@e, dac@f).
  * Removed unused properties from the adc@48 node.
- Link to v5: https://lore.kernel.org/r/20260608-ventura2_initial_dts-v5-0-37ee5bcf58b6@gmail.com

Changes in v5:
- Addressed review comments:
  * Added comments explaining the necessity of 'legacy_' prefixes (hardware label collision), pre-allocated I2C aliases (future expansions), and the 'ledd1' naming convention (schematic alignment).
  * Removed the empty `&mdio0` node to comply with upstream networking subsystem guidelines.
  * Removed the redundant `&peci0` node.
  * Sorted `&kcs3` and `&lpc_ctrl` nodes in strict alphabetical order.
- Hardware/DT alignment updates:
  * Removed unpopulated sensors (adi,adt7461, infineon,tda38640, ti,ina230, ti,ina238) to accurately reflect the current board population.
  * Added the secondary flash node (flash@1 labeled "e810") under the &spi2 bus.
- Link to v4: https://lore.kernel.org/r/20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com

Changes in v4:
- Fixed capitalization: "ventura2" -> "Ventura2".
- Reordered I2C child nodes in ascending order of unit addresses.
- Enable PECI, LPC control, and KCS3 interfaces for host communication.
- Configure MCTP controller on I2C4 and enable MCTP support for specific mux channels.
- Add Infineon TDA38640 and TI INA230 power monitor nodes.
- GPIO and Pinmux cleanup for PVT:
    - Aligned gpio-line-names as requested.
    - Remove unused or non-existent GPIO line names to align with Ventura2 PVT.
    - Update specific GPIO pins to empty strings where signals were removed or consolidated.
- Adjust SGPIOM frequency to 200kHz and update signal line names.
- Enable UART3 and add serial2 alias.
- Link to v3: https://lore.kernel.org/r/20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com

Changes in v3:
- Add annotation for marvel 88e6393x
- Modify the gpio-line-name
- Modify the node order alphabetically
- Modify dt-bindings document for rmc instead of bmc
- Move the gpio-line-names to original node
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
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2888 ++++++++++++++++++++
 3 files changed, 2890 insertions(+)
---
base-commit: 749c34389679f8d56cb200a69b62f9a64670034f
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


