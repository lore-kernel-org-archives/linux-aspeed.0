From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 6 Sep 2024 11:34:04 +0200
Subject: [PATCH v15 00/32] Add i2c-mux and eeprom devices for Meta
 Yosemite 4
In-Reply-To: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240906062701.37088-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <cc1920e9-8d9d-48b6-b593-e6c70f3f672a@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:26, Delphine CC Chiu wrote:
> Changelog:
>   - v15
>     - Add ISL28022 support
>   - v14
>     - Add SQ52205 support
>     - Add GPIO I6 pin
>   - v13
>     - Add RTQ6056-support-on-bus-11 

Stop this nonsense. Your patchset should improve, not grow with multiple
revisions with new stuff but with more and more errors.

Prepare final work, not v13 with something but without rest, thus v14
with another missing piece but still incomplete, then v15 with one more
patch but obviously not complete.

Then BEFORE you post new version fix all the oddities you have here. You
did not run checkpatch, you did not write proper commit msgs, you did
not test your DTS.

The quality of this patchset is unacceptably low.

Best regards,
Krzysztof

