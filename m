Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEE606A324
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cpKPonqr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RK6+opzw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK3vz2CpDz2y1Y;
	Wed, 04 Nov 2026 10:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793715421;
	cv=none; b=SC3li60Wcac5VVdBtiKv4f4NEXimtzRWy/wCNg+rAtnfjTL7hmimT5fqYEG8PEaU0uYjnbJlLFtSqIiFHu0N7ugkw4LUkoD75x2Ti79YGzYJo4/fsaMwdKOTyEHw9b0CAN0QQy6rYurR2d0/7ZLmBBy8p8zJT2FcARs4kontgHh4OGSuKFKwF9pIZkHhsJzBFUdk3N1V6XBE9Cs17K3X52dHgXCD4dNwwBm9V23vcGtMAxEwx9vR4EvxL89bVE8oveHdYTIB2Q2jpVdMyXgUTJv5DIYrwk1zgIQwUsCKHxG+/4eOhamUJHgTzc+Hskv66KRn4DJ4aWm53MzMntTFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793715421; c=relaxed/relaxed;
	bh=+BFi12bWqcTOJ6sEqLJK0xoOgxMvabXiHoqzjLlrk80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ei/WJKRgzG0MlsdlNhGZUO8yOSEHWajfdKPmDt4Te2HXHUkr0h6309A4r+WQahyLT5NXJORXN/nu/htEBOSqSSD1NKNcy9P3NERmf5bsv24bUXtcXkGjPnelTdLdG7/I7nhXhowqq1dECBvkuSupywKLKG+Zmu8XrrqzdI/qRXM7OynX5ls6QL7E9LEuOBcZPREZ7bXldVgfLrb8jrG88ADZxVlEr4/9rV0Amq0L0uRhuWvftSJZdj8lHT3WGwKYbBm+tYyoSOR11HRW1d1iB8huNnG0MftTkFA6w50QpTvJRP8SP7kTwAEojXUPur+l+KKfk+Ph3EEh22FDLupWQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cpKPonqr; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RK6+opzw; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cpKPonqr;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RK6+opzw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=bartosz.golaszewski@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3347 seconds by postgrey-1.37 at boromir; Wed, 04 Nov 2026 01:16:59 AEDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJrHH3kjrz2xH9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 01:16:58 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3ClER22897069
	for <linux-aspeed@lists.ozlabs.org>; Tue, 3 Nov 2026 13:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+BFi12bWqcTOJ6sEqLJK0x
	oOgxMvabXiHoqzjLlrk80=; b=cpKPonqr34zxijPWKwDHvqw2T4RXbsW/1AacZi
	4Qnxdvf6K+AKzwHKTc1uu65mtNmT2di07rdrugCPBD5AksTVGF/jQjLzjIqrixOM
	GL6jTnPrrlQgU8DZThQO24b7HyrViN0xWHkeExpJeOTgGZcJZz2dLV+xuWoiLH0O
	86a0Uq3VPJ4e3n0iNg/9Tc9WvCduY1iE7tqYydxR5DbTgTAmbDJFwGWAQVDkar83
	NHKCSLWan728eQqFBGhlyL+BjCC2OVinSm7NFfef4HigDUvX5VjCGHojEYk5g/79
	I7bB/AA6BO+iBOnTH1tA8okhpxMakMp2jeZ9hCPlhyPj7jrg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq0873va7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Nov 2026 13:20:47 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc37ee6562so644697137.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Nov 2026 05:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793712047; x=1794316847; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+BFi12bWqcTOJ6sEqLJK0xoOgxMvabXiHoqzjLlrk80=;
        b=RK6+opzwwRQ3e2vl1YuTT2zABpjK3V1Vvl68TAzAlO7s2GwjvqUeAUTE4LC8mcbqwo
         3mzvs9BeNQShsMSiVT5go34U+ln5U/WCrE1PzPjCr6Ms791av+f3DwhYyc1DaWhH9KYq
         fN17lhk5XusdF1EenjEoqOWWJHkI+JGun3x8GLeoXZLcTkFAhJnq9sdwtOOOi22qItTe
         idjz1XwuRcpFQlIkm7tULlZpTvURL0oxVV11bS0AgC4bPtpGgqrcdluQhrj7Hvh5m8Hq
         XKLXZr+63N/dBvfRsFih46j5MKFp94R8oj4B0FNwa3AYF0jlrUydvcfkHJ3pi7yd89Ve
         NHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712047; x=1794316847;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+BFi12bWqcTOJ6sEqLJK0xoOgxMvabXiHoqzjLlrk80=;
        b=uK/lGq+Oilzj/oYefyatVjJKET+gz8XBQdFTHqO+vO7kpFw039O/5um2SKq9hloesr
         0nMGFmsNx7xrue/2Aiud5t9d4d7fAJmBo9FiGYO/sqlJIKDSgPVEnUlj6w8xvhwgUw+z
         3FglQ3ImtvYmrmwTHXgQG0mGG10P8RKuZwWhfEBC5KLmQjy18U21wx0csQyHiX9q4yaL
         0N4g1NKm9cDpZ0njNJH3TwAdzyUUxJiBzKPJHwLWJTQgXsAKtRGDU76U/roLVnk5YBYy
         VMiX2JPmhIqpY7/QIQ8Hd2iz+H/vq2VqVA+/tbGAY7z064JOjCdYk6/AxnEfNuGmIw3K
         Rbbw==
X-Forwarded-Encrypted: i=1; AKwUvBzsV4CrpgyyMmjhnUf/MHuK2x5wHjYc8qDgkorRu+0obDojl2wiFUU3vtMVDMIYrWzyL07vJaiudAzVQlc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8qY+dkMaUaIrM8IZJlbBnLWDFzHffwwIQEZUwO7v6bV+6iApHP
	DeLorEdRdvIIUEeQMh0UN65eHixu+EDMU24lZAhNwfYB+yp8DUBDfjCL4JS45ILmWyIEjZ4kzR0
	cnwiL4HSJ3UD0SF9v24n2O3LKkIQovvlWqERP0Xh2N3/ypJcQc3VcywxK4cM2xvgNeWjm
X-Gm-Gg: AYBFou0XS4HttUKxB9Afd1Vaz0pcvvOpYYHDc1ir5INHl6QIAlyXtRx9aOVdgzQ7cjc
	E1v0sF9ZK8UtPUvTFkj0iOlyPIzvSXv+Fn76gR/2n/mQIbJN9uWtWxEnLfgR+CYdqXmreb6ryI5
	bhi/7Q0V6hRs7Z17eEnvdat6x8fI710EAkHcRODk1PoHJbkTGP1IrmKOTbH2wFlkkeXF7qUjc4S
	/4brP2NQsVXIlp49Uf5kCT1jHR1JHamNvUsaxWwHQRmdeNb9X8tupPnZdulxr3B+Ov6JeNL4JdQ
	Hba7WSlw5NtV2BQ4DMfXXcVSIdWFc8uwWuzAvqNn+hefLg20F/9tgqSOsDpCVFn6hfaJ+mpMorq
	Ekq7Jd46uaGUEgmcqy28d/uxii5+3q3lkAuaQQEHN9AGdNC4Nhx7Nz+OJ3IZiu7HNqErlWh3ZNj
	JTmw==
X-Received: by 2002:a05:6102:c13:b0:7ce:a69d:b020 with SMTP id ada2fe7eead31-7d072232e7dmr4404431137.5.1793712046593;
        Tue, 03 Nov 2026 05:20:46 -0800 (PST)
X-Received: by 2002:a05:6102:c13:b0:7ce:a69d:b020 with SMTP id ada2fe7eead31-7d072232e7dmr4404421137.5.1793712046016;
        Tue, 03 Nov 2026 05:20:46 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm25028605f8f.43.2026.11.03.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:20:45 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 14:20:42 +0100
Subject: [PATCH] fsi: aspeed: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
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
Message-Id: <20261103-fsi-aspeed-gpio-nonexclusive-v1-1-1fb040c59386@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKnf6WoC/x3MQQqDMBAF0KvIrDtglKatVykugvO1AyUJGRRBv
 LvB5du8gwxFYTQ0BxVsappihXs0NP1CXMAq1dS1nXeu7Xk25WAZEF6yJo4pYp/+q+kG7kWCF/d
 6fvybapELZt3v/jue5wWazr8fbgAAAA==
X-Change-ID: 20261103-fsi-aspeed-gpio-nonexclusive-3dda6d175968
To: Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JM4hxUuDHFTKWRhWdb7Y0Uxm9PMGHQj200nKYHyrYSQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6d+sehilbkXKePTpQgQLuD9189WQlF28F6T9I
 V48CXFl2ACJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaunfrAAKCRAFnS7L/zaE
 wzsLD/sF/61Ts6Vl9U1VcfUV+7ggD61FAlUXLtBKNyTjHiX0HkjN9eP0cHAw5zg8n7GuNyHt+EF
 iEDpgCrXHP2zr1ihPlySUvhY+FOuCrc7v0+hz/R7vNRwRfyWIagRxUs3Ie12UDY8W0JSsN3TtHH
 vvJtFquRlw0DDk2ZR6vWYyfKiacbSqogBp+mMRkTr05O5go/cr/al/FBc+wsK36UxBGhUkS1fBX
 moOhqrXCaYRIVRf54qMYOGg0TLG4jwd54NKTzaLQp1ANQ3ipb2sgY+9M7f9pmwuRmAdE8EIKkKP
 w6uNzCdV7u6AZ970yxsacAuTjjFShmP653M4ycK73dFsNyaQU95EOjZXC8Uzgo6qCm8gCBoSFbR
 BWiv4AdasEoDL5fmCDHORU9APEAggAxy1EbL0mAgS5byGLCZf72WAF9qh05Mea2lMgrEYhThLbT
 nWm+3D1EJb4JjDEojVo5evlfAc67c2Ttb8m7xrG+ziXIYKrOTdOPFTNsdPJH2V/f3aun4mU1zyU
 BOCBxw0sb6pOYfGQCojViGgWxZ8P+QtzUtsbQ+5S3tNSYRFqDsJsPCjRUqJe0rgHd3PAQib8Y6f
 qXL6cHYOKZu/Trd0DLQyCk9stc3brh8bf1rQo9iDFoHm/xNSOObDWOoTy14uhNpveFCSI4lvwqB
 6Z6tJwa+9K/jT/A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfX0xdMQL4YiPfl
 bLaBKwpnlH0Lk/gAc9xFZY59EnAP/JbgOjz5XamFcOqRMg6KhBP2fj8TMbNRv3M1yrDd7JSrK8i
 +J4T4v59lQV2PDUypn5N0b6czEEmmdU=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae9dfaf cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=FqAFu7yXOSDO3m4w5aYA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfX1F8I7l8ps7yH
 7vNu2CTY0bEh4Cci5PLg9GLoEojxXb/xILoNV+cEP4yBpmCl/eLZT3q/ii54L84hJZpILckExZv
 GZWGOEzygtXkJUzST7p3Zlx1ZRkvaUxBruVzwRWm0dgyWANzpq5p6li3jref9CI9rnmbHqoLMhk
 BZ8woaaVQtW6IrZtOy4NWdYBf3dQ1DAhMx00I3AWbYXlIEWpXIN5+ms1U+QpOrk9MDDu6BLc7pV
 SNqqDfqn65LlooHtbxcKT+7ZcTbaDU0DEwdtgqaETESxO9l5KSHwjzarx0+YXgHM9ws+WEMKHUB
 G1pr9aeu5xrbDniStqI/MjR6RDtqYfUzkg5KCAocYTeDk+2Q7dNlcf/FCgHx5MDc5etqtqMae1z
 6uGbzgFOBN+dprx7bYazDfp7HaWjqEt+41UkVulTGJX1aox7J6z2Kpzk7/lNB7sODXZZkLmfiHB
 b13PA/fJII68ssw/b8A==
X-Proofpoint-ORIG-GUID: 1oSyRKFKuKbXFhzS2FKiv7-PGiRFQeNK
X-Proofpoint-GUID: 1oSyRKFKuKbXFhzS2FKiv7-PGiRFQeNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030053
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There are no users that share fsi-routing-gpios in any of the upstream
DT sources. Even if there were, the right thing to do would be enable
HAVE_SHARED_GPIOS for the aspeed platform as this is the preferred way
of sharing GPIO pins. Don't request the GPIO as non-exclusive as this
flag is now deprecated and will be removed.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index aa1380cdff338dfef7caa8d516322e6bf90371cd..88a3a90abef9cd22cae03f5666936ef7eced8a7d 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -496,8 +496,7 @@ static int tacoma_cabled_fsi_fixup(struct device *dev)
 	 * The routing GPIO is a jumper indicating we should mux for the
 	 * externally connected FSI cable.
 	 */
-	routing_gpio = devm_gpiod_get_optional(dev, "fsi-routing",
-			GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	routing_gpio = devm_gpiod_get_optional(dev, "fsi-routing", GPIOD_IN);
 	if (IS_ERR(routing_gpio))
 		return PTR_ERR(routing_gpio);
 	if (!routing_gpio)

---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-fsi-aspeed-gpio-nonexclusive-3dda6d175968

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


