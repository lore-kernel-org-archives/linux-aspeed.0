Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C6606A31B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sj48FKi9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HNCvhvZJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLHNp4mfVz2yfs;
	Fri, 06 Nov 2026 09:41:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793881498;
	cv=none; b=QTC8Llp44/WVKeE24GvD1qT/ZsFzSOezWorqF0SWgq9a+24jwp6vpYSkUhGalHre/g8jghaNK6k+HhjTtvK4GhrjFOsSkSz2RDhPXK/PAf0JIENs7MU0xMfQP75Z1SKUTU2uXGWDD78G3r45j3J3EyRGa3PMuudCjkO8dg4Ix0ATv9TRIc7xtZQfE1l20qP9MoMEIs7fhEp40M14oj03N0zfug2ToukKXl07o8PgwHXWcvIMZbkF2kLrwSDRRasksPb05Qwe8O6YklhKNfrNhzTbC6VT+QPeAOAifkOiVahhVcml+J/XIIbqWcYtf2h7i2YtRSr3SETW0ctAM0NiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793881498; c=relaxed/relaxed;
	bh=662NwdLNBtUdGCmzgsMnPMmCnx3lvo2FazCLn8DNyc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU9YOvziRx0aRAU1usaRFUyYy1uFXGkIqtCVMS8hMLdmSSFYpLhyBr1hUL6sTdpDfHHNBTpSaF9JhNgq4PKITQ1UprA+FpJ7ZCP+FSeAaPkFEv5ZSQ13p8Star80xHzZ60XDkbBBdugi7t6VR5dyApTuSzTxGYqQmmFGS0+vGHlTV6YSaTopt+wpq67nWH3Yls4NFo5ISvhZQldJJb971Ra4PZEGRjtNIKZnUPo0FG4GN2S2vBF6WBEZL6vBe0eAe8HRaGxzQ2nQiLxMffucx018IIU5QtUlwizTTT380f6jyGzsK47RKGUuy3zK57oMloniSWUeeq7CbHZRk/X22w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sj48FKi9; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HNCvhvZJ; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sj48FKi9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HNCvhvZJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL1j456R9z2xSV
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 23:24:55 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tDDg444472
	for <linux-aspeed@lists.ozlabs.org>; Thu, 5 Nov 2026 12:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	662NwdLNBtUdGCmzgsMnPMmCnx3lvo2FazCLn8DNyc4=; b=Sj48FKi9APQlwcOq
	GDAZNmLT3CXSYY9O+PaU3TtvVQysmkBy1nFGyuUMO4SfoWoJlZtUpXCJkjnuYpzY
	XhLBH0rApGtho+uA+IAj5i07YLstmB9uL4i1XBq2Fn4pAjyqtB4XhAj1DTYr86gX
	5h0QIcNnJeXfVZBVW2XVKnFiBhtzA0BEg55NXJZTELlnDMVuiU85I18Gm8uTrsjx
	Bm4Xmm9nnEkThsG1fvHwBfQqWaknlaKGAGhtveTyrF84F1glilfOAmggfSRVvvEd
	rbtpKEm24aw9iEU5HrfbsTHWAsez6HxgkStnDOX7IuVgh3p0wZQ2I3uPsLJI53R4
	TL6jqw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaagy6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 12:24:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f32050e72so554829985a.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 04:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793881492; x=1794486292; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=662NwdLNBtUdGCmzgsMnPMmCnx3lvo2FazCLn8DNyc4=;
        b=HNCvhvZJhIsKpLXzRzFZd2cetdg0TcF481dwO/1mP1dTjRsOPXoX5HIDx2LbyO77vJ
         HeuOCgjVYRa+JzeCIvBYzPmLumxgtn9U9cM2L87XHte+4R677WoDxf3ieue2sGXqVGkl
         4kS4NojOAv21xeOM5z7NQTEjnc0z9VfU+Bw6L2BeaQS3qIsqmuybRRnNblsOSp79XJrD
         e6pTjjU8VFEmtp3hRR6kxOK8al9vBRONDkCqKoVM+WMo9dIWCJOhFIEQcISRQKXuPBF0
         7CN7pPZdOFEE0VE1ejaMuY83B/xmasyRDatppRZ56TCYsKdcaPr+492lj82+WjKZiUQR
         ZkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881492; x=1794486292;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=662NwdLNBtUdGCmzgsMnPMmCnx3lvo2FazCLn8DNyc4=;
        b=ZWW1KQV36N0fy717Dsvk8fvQcQc4eWEjL1J38sIzbLNY5jMVoSvnH0IS0UeFaQNDbV
         iPS29/iICVKGnM78TA68BCIIldUZhR8bLd+kcaju4rpcpeTnRE3jeFigzds6VYnuoi9J
         N7RetSz0dg5q9XsILPjQZpEM3Y8WidzKOvMcM5XKvNHoSclqRRGmZS/uZ/i0XjHr0axw
         McWdwexIloRMiFtCD1TGlcD44M2gbi/j8bWcAhTjx5Y1zdJqH5YxIgEW2IcnIHhEieZ+
         T6gDlD5EtYcY0Kqr1mGH4RPN+aqjlxHmz7T8bwW89ZRgSS8AKNQfaqcZ6z1m/dp3bwkp
         FUYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwU1kDKCaLK03NnQ7zdPu6bA5kkhDAXOhhVAQ8wpPrDvt4JAH6/32EsYQ1FWhPte9B/NcLnBWPopL9qlI4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+SWSPqQxFYGn4DFKZywq0gOcrmOx0GVF0Skxr9yE6bircxxf/2
	hWVhStMzTOtHc61JthJjIR207VSpV2DlkxlFZxsh2GYO3nkHMH5/cuEtUoqYBacYkDVQXztYEKp
	HJNLBxuMeRtqzFyMpGDKFK9qwpjwyXXs55yxvCPKGu1wRxz9kVKlQUtEMe5uEzlgzgsXf
X-Gm-Gg: AYBFou2Jeh/RinFgix4gakdT8FrS2C+noszpi92v2sLFwz6RjEORZ3XpeoxVI5zAY/+
	XPqEk0wpzXfbZ4V6JtnhAJ0l8UUahae2sz3P1qNuVwVH+1YuBVFHPMHir6uUXhRTjJM1ByG8doF
	L0zKvzjxx0L/pdBhoYojiwtokew2vNR3sMj7vO9TXFZN+DoFN9DcZ9yNvXLKSWC4KVB8a4J71yg
	4qC1FGAdl1BuPX4p4vG/y+RRFBmmudEOhBx2W6B8ULyjZj6QUL5aYnAtSzPMrCn+ruSQXz6psl8
	I57zsznMQLMlG3oEYfOncJEyT9q1wtYXY4qSW0Fbq6wL2iM1Y2o++l49wTCNLu37TND0wmxemg4
	HnD1n7ePzyfQcG879A10loAnW9Js63FjdWTTydLwnhIU7skzfq1uV8sgCZnmpwqyjoToxq6ZKyN
	78
X-Received: by 2002:a05:620a:1a0e:b0:93f:2ab9:72a0 with SMTP id af79cd13be357-9442172e3a8mr3096716485a.70.1793881492185;
        Thu, 05 Nov 2026 04:24:52 -0800 (PST)
X-Received: by 2002:a05:620a:1a0e:b0:93f:2ab9:72a0 with SMTP id af79cd13be357-9442172e3a8mr3096707785a.70.1793881491600;
        Thu, 05 Nov 2026 04:24:51 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725fb0d1sm61320965e9.8.2026.11.05.04.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:24:50 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
        Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        linux-hwmon@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org,
        asahi@lists.linux.dev, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, Michael Buesch <m@bues.ch>,
        William Breathitt Gray <wbg@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Date: Thu,  5 Nov 2026 13:24:47 +0100
Message-ID: <179388146665.22103.2916811858448928630.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0OSBTYWx0ZWRfX39V9MwtTfQiG
 Uiqjn1amS2kbRDsTWeVbHpGJy/AC9+DCqGBuAp+bgOYGV1dvEXyPtr5UUYHehDdMSttiuxzoxq+
 976y6bQChZpf1t+OlJ7r48yCyxH9mWiUo0p4dwcQYN6Zkm/5gKJ7/GROoXsaqu5zTK7BUZzbWfx
 4sOdqhNPoUbUBer0SOHkFFTlPM5BC/lZOmfvpyD9wadsz1QULiXee1l0AfQCMoZHRzZO2pIBHos
 et7iA39BIrvznBCvWrJlSZrX1G4OnbSUAKA5zv6Oud5HOjD4Cd4riBdSIgUqf9KmD+ofo3Gl9RT
 HTkZxQM4SQJ1VL4jHtRVm1f0LwNsM1TbaIlaXlKg3OH3E8Af2+QavWHejFcxEkOXNIboct6Nzf0
 3JOiI6fMVk9fXxyvg+KOt2Hy1k6+hY24NShk0jrCBncTgi16rQtKe1FICZ5RMsAppyunZipQoR9
 VbTsm8bnw7C3ALh5IUw==
X-Proofpoint-GUID: 15crEwxt5udYdjm8AZguYEsNDv2-OneA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0OSBTYWx0ZWRfX4fKY9sRYOrov
 8gSUABzPeSJX08MQcxUbMfcAFaEfSj9XmnCiwtf8VtxammBi6WYnRy8rok++Nt9UjCGeqAC+cm9
 H7LKrZduui91cuNs7av9DSbIBtdBGhw=
X-Proofpoint-ORIG-GUID: 15crEwxt5udYdjm8AZguYEsNDv2-OneA
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec7595 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=k4E0auTuH4aaYxdkK-0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050049
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 27 Oct 2026 11:48:37 +0100, Uwe Kleine-König (The Capable Hub) wrote:
> the original motivation for this series are the patches that convert the
> arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the idea behind it. Looking left and right a bit while implementing
> that, the series grew a bit.
> 
> Changes since v3 (available at
> https://lore.kernel.org/all/cover.1793030820.git.u.kleine-koenig@baylibre.com):
> 
> [...]

Applied, thanks!

[01/23] gpio: Remove __maybe_unused annotations from acpi_device_id arrays
        https://git.kernel.org/brgl/c/c563f9a7ebdb8de36042b685c89b29a56bb4a2d8
[02/23] gpio: fxl6408: Remove __maybe_unused annotations from of_device_id array
        https://git.kernel.org/brgl/c/9ae231ac040cbdd9e24dda8a76e5b0a52195fca3
[03/23] gpio: Drop unused assignment of acpi_device_id driver data
        https://git.kernel.org/brgl/c/7a2dac6de054da359a0f986dc9b8fe7a1c2a97e4
[04/23] gpio: max7301: Drop unused assignment of spi_device_id driver data
        https://git.kernel.org/brgl/c/9d6f21a8154ebcf777d9836f2c804f65c4173b02
[05/23] gpio: mmio: Drop unused assignment of platform_device_id driver data
        https://git.kernel.org/brgl/c/9d14e246391f0caafcffa7fe5211b32d246fb327
[06/23] gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
        https://git.kernel.org/brgl/c/526fd5a299da4e954a66124464fc272b9d6ec529
[07/23] gpio: xgene: Add missing ACPI module annotation
        https://git.kernel.org/brgl/c/c7b4f8ea5725363bb7209be26cd57428e534eb4c
[08/23] gpio: sodaville: Add missing PCI module annotations
        https://git.kernel.org/brgl/c/77e387153e2a871d1bd84fa170d1e0c2ba2cf78d
[09/23] gpio: Add missing OF module annotations
        https://git.kernel.org/brgl/c/93ff9d3beb2a20c7cc5a5d60e81de8ba8e770338
[10/23] gpio: pxa: Add missing platform module annotations
        https://git.kernel.org/brgl/c/1a93b8060780bc50b9348d28224986a3552f5d87
[11/23] gpio: pl061: Use empty initializer for amba_id terminator
        https://git.kernel.org/brgl/c/501a0376a582abee825d25fba42ab6f9f80433be
[12/23] gpio: Use named initializers for acpi_device_id array
        https://git.kernel.org/brgl/c/91f7e7fb10592850a7d9075e16aee5fbe83f1e9a
[13/23] gpio: Use named initializers for auxiliary_device_id arrays
        https://git.kernel.org/brgl/c/b3ef6bfd0e14450debf728225894b70a3379f514
[14/23] gpio: pcf857x: Use named initializers for of_device_id array
        https://git.kernel.org/brgl/c/5b2dcd61c2105f5b17591c3c44b10630d68001f7
[15/23] gpio: bd73800: Use named initializers for platform_device_id array
        https://git.kernel.org/brgl/c/92aa1d97bd10195df229851f4e008914a0e8445f
[16/23] gpio: Use named initializers for spi_device_id array
        https://git.kernel.org/brgl/c/7b86d1e3c33b95a85a5a3e6f72afdcc2ff717e0d
[17/23] gpio: virtio: Use a named initializer for virtio_device_id array
        https://git.kernel.org/brgl/c/7c01eb6861833cfb9d00673fbf8aef0b3e330dbe
[18/23] gpio: Unify style of acpi_device_id arrays
        https://git.kernel.org/brgl/c/6588211f4fe51a881ca56648dcc5a8fa1479d4e2
[19/23] gpio: Unify style of of_device_id arrays
        https://git.kernel.org/brgl/c/aee4187b00011bb65ee1aef578b1fceafae76fba
[20/23] gpio: max77620: Unify style of platform_device_id array
        https://git.kernel.org/brgl/c/1b454163287b3839bdfd219e3520456ce251bbe5
[21/23] gpio: Unify style of spi_device_id arrays
        https://git.kernel.org/brgl/c/17d6308e7d5a4d4f317c7f92cbca330bffcfc391
[22/23] gpio: Unify style of pci_device_id arrays
        https://git.kernel.org/brgl/c/aff8eccdb976f43298117b52a7bae6d13ca62554
[23/23] gpio: Unify style of various *_device_id arrays
        https://git.kernel.org/brgl/c/0fa38ba784896f2fc32c9dacd33822f844b21906

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

